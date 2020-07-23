import 'dart:convert';
import 'package:eaw/dto/HomeResponse.dart';
import 'package:eaw/dto/RequestQR.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:http/http.dart' as http;

class HomeProvider {
  Future<HomeResponse> getHome(String userToken, int userId) async {
    HomeResponse homeResponse;
    String url = BaseURL.baseURL + UrlApi.getHome + "?id=$userId";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    http.Response response;
    try {
      response = await http.get(url, headers: headers);
    } catch (e) {
      print(e);
      return null;
    }
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      final responseJson = json.decode(json.decode(response.body));
      homeResponse = new HomeResponse.fromJson(responseJson);
      return homeResponse;
    }
    return homeResponse;
  }

  Future sendRequestAttendanceByQr(
      RequestQr requestQr, String userToken) async {
    String url = BaseURL.baseURL + UrlApi.sendRequestQR;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    String json =
        '{"empCode": "${requestQr.empCode}","faceMachineCode": "${requestQr.faceMachineCode}","mode": "${requestQr.mode}","createTime": "${requestQr.createTime}","wifiName": "${requestQr.wifiName}"}';
    http.Response response;
    try {
      response = await http.post(url, headers: headers, body: json);
    } catch (e) {
      print(e);
      return null;
    }
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      return true;
    }
    return false;
  }
}
