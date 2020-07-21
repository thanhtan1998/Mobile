import 'dart:convert';
import 'package:eaw/dto/ScheduleResponse.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'package:http/http.dart' as http;

class ScheduleProvider {
  Future<ScheduleResponse> getSchedule(String userToken, int userId,
      DateTime startDate, DateTime endDate) async {
    ScheduleResponse scheduleResponse;
    String url = BaseURL.baseURL +
        UrlApi.getSchedule +
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
      scheduleResponse = new ScheduleResponse.fromJson(responseJson);
      return scheduleResponse;
    }
    return scheduleResponse;
  }
}
