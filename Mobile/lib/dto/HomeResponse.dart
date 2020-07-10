import 'package:eaw/dto/LastAttendance.dart';
import 'package:eaw/dto/NextWorkShift.dart';

class HomeResponse {
  String userName;
  double totalHours;
  LastAttendance lastAttendance;
  String image;
  NextWorkShift nextWorkShift;
  HomeResponse(
      {this.userName,
      this.totalHours,
      this.lastAttendance,
      this.image,
      this.nextWorkShift});
  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return new HomeResponse(
        userName: json['name'] != null ? json['name'] : null,
        image: json['image'] != null ? json['image'] : null,
        lastAttendance: json['lastAttendance'] != null
            ? LastAttendance.fromJson(json['lastAttendance'])
            : null,
        totalHours:
            json['totalTimeDouble'] != null ? json['totalTimeDouble'] : null,
        nextWorkShift:json['NextWorkShift']  != null
            ? NextWorkShift.fromJson(json['NextWorkShift'])
            : null);
  }
}
