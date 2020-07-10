
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
        startDate: json['Start']!= null ? json['Start'] : null,
        endDate: json['End']!= null ? json['End'] : null,
        address: json['address']!= null ? json['address'] : null,
        storeName: json['storeName']!= null ? json['storeName'] : null,
        totalTime: json['totalTime']!= null ? json['totalTime'] : null,
        workDate: json['workDate']!= null ? json['workDate'] : null);
  }
}