class LoginResponse {
  int userId;
  String userToken;
  String userName;
  String image;
  LoginResponse({this.userId, this.userToken, this.userName, this.image});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['id'] != null ? json['id'] : null,
      userToken: json['tokenString'] != null ? json['tokenString'] : null,
      image: json['image'] != null ? json['image'] : null,
      userName: json['username'] != null ? json['username'] : null,
    );
  }
}
