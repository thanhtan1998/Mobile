import 'package:eaw/dto/History.dart';

class HistoryResponse {
  Map<String, History> listOfHistory;
  HistoryResponse({this.listOfHistory});
  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    List listData = json['schedule'] != null ? json['schedule'] : null;
    Map<String, History> map = Map();
    for (var item in listData) {
      History schedule = History.fromJson(item);
      map.putIfAbsent(schedule.date, () => schedule);
    }
    return HistoryResponse(listOfHistory: map);
  }
}
