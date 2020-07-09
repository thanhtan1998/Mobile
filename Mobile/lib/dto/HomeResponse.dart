import 'package:eaw/dto/LastAttendance.dart';
import 'package:eaw/dto/NextWorkShift.dart';

class HomeResponse{
    int userId;
    String userName;
    double totalHours;
    LastAttendance lastAttendance;
    String image;
    NextWorkShift nextWorkShift;
    HomeResponse({this.userId, this.userName, this.totalHours,
        this.lastAttendance, this.image,this.nextWorkShift});
    factory HomeResponse.fromJson(Map<String, dynamic> json){
        return new HomeResponse(userId: json['id'],userName:  json['name'],image:  json['image'],
            lastAttendance:  LastAttendance.fromJson(json['lastAttendance']),totalHours: json['totalTimeDouble'],
        nextWorkShift: NextWorkShift.fromJson(json['NextWorkShift']));
    }
}