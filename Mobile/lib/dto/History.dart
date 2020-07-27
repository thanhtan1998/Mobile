class History {
  String date, time, storeName, mode, status, imageCheckFace;
  History(
      {this.date,
      this.imageCheckFace,
      this.status,
      this.storeName,
      this.mode,
      this.time});
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        date: json['date'] != null ? json['date'] : null,
        time: json['time'] != null ? json['time'] : null,
        mode: json['mode'] != null ? json['mode'] : null,
        imageCheckFace: json['image'] != null ? json['image'] : null,
        status: json['status'] != null ? json['status'] : null,
        storeName: json['Store'] != null ? json['Store'] : null);
  }
}
