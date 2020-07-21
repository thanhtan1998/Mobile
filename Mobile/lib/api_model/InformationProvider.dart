import 'dart:convert';

import 'package:eaw/dto/InformationResponse.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:http/http.dart';

class InformationProvider {
  Future<InformationResponse> getInformation(
      String userToken, int userId) async {
    InformationResponse informationResponse;
    String url = BaseURL.baseURL + UrlApi.getInformation + "?id=$userId";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    Response response;
    try {
      response = await get(url, headers: headers);
    } catch (e) {
      print(e);
      return null;
    }
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      final responseJson = json.decode(json.decode(response.body));
      informationResponse = new InformationResponse.fromJson(responseJson);
      return informationResponse;
    }
    return informationResponse;
  }

  Future<InformationResponse> updateInformation(
      String userToken, int userId, String titleUpdate, Object value) async {
    var tempTitle;
    switch (titleUpdate) {
      case 'Sinh nhật':
        tempTitle = 'birth';
        break;
      case 'Địa chỉ':
        tempTitle = 'address';
        break;
      case 'Số điện thoại':
        tempTitle = 'phone';
        break;
      default:
        break;
    }
    InformationResponse informationResponse;
    String url =
        BaseURL.baseURL + UrlApi.updateInfor + "?id=$userId&$tempTitle=$value";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    Response response = await put(url, headers: headers);
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      final responseJson = json.decode(json.decode(response.body));
      informationResponse = new InformationResponse.fromJson(responseJson);
      print("object");
      return informationResponse;
    }
    return informationResponse;
  }
}
