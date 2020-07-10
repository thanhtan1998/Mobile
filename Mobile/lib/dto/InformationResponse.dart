class InformationResponse {
  String phone, email, address, role, brand, dayOfBirth;
  InformationResponse(
      {this.phone,
      this.email,
      this.address,
      this.brand,
      this.role,
      this.dayOfBirth});

  factory InformationResponse.fromJson(Map<String, dynamic> json) {
    return InformationResponse(
      address: json["address"] != null ? json['address'] : null,
      brand: json["brand"] != null ? json['brand'] : null,
      email: json["email"] != null ? json['email'] : null,
      phone: json["phone"] != null ? json['phone'] : null,
      role: json["role"] != null ? json['role'] : null,
      dayOfBirth: json["birthday"] != null ? json['birthday'] : null,
    );
  }
}
