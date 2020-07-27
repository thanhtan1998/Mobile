import 'dart:convert';

import 'package:eaw/dto/HistoryResponse.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:http/http.dart' as http;

class HistoryProvider {
  Future<HistoryResponse> getHistory(String userToken, int userId,
      DateTime startDate, DateTime endDate) async {
    HistoryResponse historyResponse;
    String url = BaseURL.baseURL +
        UrlApi.getHistory +
        "?id=$userId&firstDate=$startDate&lastDate=$endDate";
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
      historyResponse = new HistoryResponse.fromJson(responseJson);
      return historyResponse;
    }
    return historyResponse;
  }

  Future sendRequest(String userToken, int userId, String createTime,
      String content, String wifiName) async {
    String url = BaseURL.baseURL + UrlApi.sendRequest;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    String json =
        '{ "createTime": "$createTime", "content": "$content", "nameWifi": "$wifiName", "id": $userId}';
    http.Response response = await http.post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    if (statusCode == BaseURL.successCode) {
      return true;
    }
    return false;
  }
}
