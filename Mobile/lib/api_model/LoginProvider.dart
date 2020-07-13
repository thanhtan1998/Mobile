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
    // loginResponse = new LoginResponse(
    //     userId: 8,
    //     userToken:
    //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRhbm50c2U2MzE4NEBmcHQuZWR1LnZuIiwiZXhwIjoxNTk1MDkwNDE4LCJpc3MiOiJUZXN0LmNvbSIsImF1ZCI6IlRlc3QuY29tIn0.WeCSvmPy0ku64Gs-kLbLX-eKA7wCyCsChSaOPHeUMwA");
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      final responseJson = jsonDecode(response.body);
      loginResponse = new LoginResponse.fromJson(responseJson);
      return loginResponse;
    }
    return loginResponse;
  }
}

final loginPro = LoginProvider();
