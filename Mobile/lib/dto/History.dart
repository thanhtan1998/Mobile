class History {
  String date, checkin, storeName, address, brandName, imageCheckFace;
  bool status;
  History(
      {this.address,
      this.brandName,
      this.checkin,
      this.date,
      this.imageCheckFace,
      this.status,
      this.storeName});
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        checkin: json['checkin'] != null ? json['checkin'] : null,
        date: json['date'] != null ? json['date'] : null,
        imageCheckFace:
            json['imageCheckFace'] != null ? json['imageCheckFace'] : null,
        status: json['status'] != null ? json['status'] : null,
        storeName: json['storeName'] != null ? json['storeName'] : null,
        brandName: json['brandName'] != null ? json['brandName'] : null,
        address: json['AddressStore'] != null ? json['AddressStore'] : null);
  }
}
