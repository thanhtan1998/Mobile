

class HomeResponse{
    int userId;
    String userName;
    double totalHours;
    String lastAttendance;
    String image;

    HomeResponse({this.userId, this.userName, this.totalHours,
        this.lastAttendance, this.image});
    factory HomeResponse.fromJson(Map<String, dynamic> json){
        return new HomeResponse(userId: json['id'],userName:  json['name'],image:  json['image'],
            lastAttendance:  json['detailWorkShift'],totalHours: json['totalTimeDouble'] );
    }
}