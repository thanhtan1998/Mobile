
class LastAttendance{
  String startDate,endDate,totalTime,storeName,address,workDate;
  LastAttendance(
      {this.startDate,
      this.endDate,
      this.workDate,
      this.totalTime,
      this.storeName,
      this.address});

  factory LastAttendance.fromJson(Map<String, dynamic> json) {
    return new LastAttendance(
        startDate: json['Start'],
        endDate: json['End'],
        address: json['address'],
        storeName: json['storeName'],
        totalTime: json['totalTime'],
        workDate: json['workDate']);
  }
}