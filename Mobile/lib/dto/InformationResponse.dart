class InformationResponse {
  String  phone, email, address, role, brand, dayOfBirth;

  InformationResponse(
      {
      this.phone,
      this.email,
      this.address,
      this.brand,
      this.role,
      this.dayOfBirth});

  factory InformationResponse.fromJson(Map<String, dynamic> json) {
    return InformationResponse(
        address: json["address"],
        brand: json["brand"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        dayOfBirth: json["birthday"],
    );

  }
}
