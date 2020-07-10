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
        startDate: json['Start']!= null ? json['Start'] : null,
        endDate: json['End']!= null ? json['End'] : null,
        address: json['address']!= null ? json['address'] : null,
        storeName: json['storeName']!= null ? json['storeName'] : null,
        totalTime: json['totalTime']!= null ? json['totalTime'] : null,
        workDate: json['workDate']!= null ? json['workDate'] : null);
  }
}
