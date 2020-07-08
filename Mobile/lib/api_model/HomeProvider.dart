import 'dart:convert';
import 'package:eaw/dto/HomeResponse.dart';
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
    http.Response response = await http.get(url, headers: headers);
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      final responseJson = json.decode(json.decode(response.body));
      homeResponse = new HomeResponse.fromJson(responseJson);
      return homeResponse;
    }
    return homeResponse;
  }
}
