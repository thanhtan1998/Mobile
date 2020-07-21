import 'package:eaw/dto/LastAttendance.dart';
import 'package:eaw/dto/NextWorkShift.dart';

class HomeResponse {
  String empCode;
  double totalHours;
  LastAttendance lastAttendance;

  NextWorkShift nextWorkShift;
  HomeResponse(
      {this.totalHours, this.lastAttendance, this.nextWorkShift, this.empCode});
  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return new HomeResponse(
      lastAttendance: json['lastAttendance'] != null
          ? LastAttendance.fromJson(json['lastAttendance'])
          : null,
      totalHours:
          json['totalTimeDouble'] != null ? json['totalTimeDouble'] : null,
      nextWorkShift: json['NextWorkShift'] != null
          ? NextWorkShift.fromJson(json['NextWorkShift'])
          : null,
      empCode: json['empCode'] != null ? json['empCode'] : null,
    );
  }
}
