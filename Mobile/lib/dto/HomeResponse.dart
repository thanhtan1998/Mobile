

class HomeResponse{
    String userId;
    String userName;
    String totalHours;
    String lastAttendance;
    String image;

    HomeResponse(this.userId, this.userName, this.totalHours,
        this.lastAttendance, this.image);

    factory HomeResponse.fromJson(){

    }
}