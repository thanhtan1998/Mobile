import 'dart:convert';
import 'package:eaw/dto/LoginRequest.dart';
import 'package:eaw/dto/LoginResponse.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:http/http.dart' as http;

class LoginProvider {
  Future<LoginResponse> checkLogin(LoginRequest loginRequest) async {
    String url = BaseURL.baseURL + UrlApi.checkLogin;
    LoginResponse loginResponse;
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"firebaseToken": "${loginRequest.firebaseToken}", "tokenFcm": "${loginRequest.fcmToken}"}';
    http.Response response = await http.post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      final responseJson = jsonDecode(response.body);
      loginResponse = new LoginResponse.fromJson(responseJson);
      return loginResponse;
    }
    if (statusCode == BaseURL.notFoundCode) {
      return null;
    }
    return loginResponse;
  }
}

final loginPro = LoginProvider();
