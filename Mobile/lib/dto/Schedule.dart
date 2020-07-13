class Schedule {
  String date, startDate, endDate, brandName, storeName, address;
  bool status;
  Schedule(
      {this.startDate,
      this.endDate,
      this.brandName,
      this.storeName,
      this.status,
      this.address,
      this.date});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        startDate: json['checkin'] != null ? json['checkin'] : null,
        date: json['date'] != null ? json['date'] : null,
        endDate: json['checkout'] != null ? json['checkout'] : null,
        status: json['status'] != null ? json['status'] : null,
        storeName: json['storeName'] != null ? json['storeName'] : null,
        brandName: json['brandName'] != null ? json['brandName'] : null,
        address: json['AddressStore'] != null ? json['AddressStore'] : null);
  }
}
