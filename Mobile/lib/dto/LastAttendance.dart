class LastAttendance {
  String date, mode, time, storeName, status;
  LastAttendance(
      {this.date, this.mode, this.storeName, this.status, this.time});
  factory LastAttendance.fromJson(Map<String, dynamic> json) {
    return new LastAttendance(
        status: json['status'] != null ? json['status'] : null,
        mode: json['mode'] != null ? json['mode'] : null,
        storeName: json['Store'] != null ? json['Store'] : null,
        date: json['date'] != null ? json['date'] : null,
        time: json['time'] != null ? json['time'] : null);
  }
}
