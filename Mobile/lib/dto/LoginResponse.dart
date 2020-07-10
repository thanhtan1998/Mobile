class LoginResponse {
  int userId;
  String userToken;
  LoginResponse({this.userId, this.userToken});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['id'] != null ? json['id'] : null,
      userToken: json['tokenString'] != null ? json['tokenString'] : null,
    );
  }
}
