import 'dart:convert';

import 'package:eaw/dto/InformationResponse.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:http/http.dart';

class InformationProvider{
  Future<InformationResponse> getInformation(String userToken, int userId) async {
    InformationResponse informationResponse;
    String url = BaseURL.baseURL + UrlApi.getInformation + "?id=$userId";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
   Response response = await get(url, headers: headers);
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
