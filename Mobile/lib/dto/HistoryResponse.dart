import 'package:eaw/dto/History.dart';

class HistoryResponse {
  List<History> listOfHistory;
  HistoryResponse({this.listOfHistory});
  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    List listData =
        json['HistoryAttendance'] != null ? json['HistoryAttendance'] : null;
    List<History> tempList = List<History>();
    for (var item in listData) {
      History schedule = History.fromJson(item);
      tempList.add(schedule);
    }
    return HistoryResponse(listOfHistory: tempList);
  }
}
