import 'package:eaw/dto/Schedule.dart';

class ScheduleResponse {
  Map<String, Schedule> listOfSchedule;
  ScheduleResponse({this.listOfSchedule});
  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    List listData = json['schedule'] != null ? json['schedule'] : null;
    Map<String, Schedule> map = Map();
    for (var item in listData) {
      Schedule schedule = Schedule.fromJson(item);
      map.putIfAbsent(schedule.date, () => schedule);
    }
    return ScheduleResponse(listOfSchedule: map);
  }
}
