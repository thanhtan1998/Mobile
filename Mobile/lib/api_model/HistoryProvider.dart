import 'dart:convert';

import 'package:eaw/dto/HistoryResponse.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:http/http.dart' as http;

class HistoryProvider {
  Future<HistoryResponse> getHistory(String userToken, int userId,
      DateTime startDate, DateTime endDate) async {
    HistoryResponse scheduleResponse;
    String url = BaseURL.baseURL +
        UrlApi.getHistory +
        "?id=$userId&firstDate=$startDate&lastDate=$endDate";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    http.Response response = await http.get(url, headers: headers);
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      final responseJson = json.decode(json.decode(response.body));
      scheduleResponse = new HistoryResponse.fromJson(responseJson);
      print("object");
      return scheduleResponse;
    }
    return scheduleResponse;
  }
}
