class NextWorkShift {
  String startDate, endDate, totalTime, storeName, address, workDate;
  NextWorkShift(
      {this.startDate,
      this.endDate,
      this.workDate,
      this.totalTime,
      this.storeName,
      this.address});

  factory NextWorkShift.fromJson(Map<String, dynamic> json) {
    return new NextWorkShift(
        startDate: json['Start'],
        endDate: json['End'],
        address: json['address'],
        storeName: json['storeName'],
        totalTime: json['totalTime'],
        workDate: json['workDate']);
  }
}
