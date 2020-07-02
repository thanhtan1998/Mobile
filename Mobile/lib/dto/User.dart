class User {
  int _id;
  String _email;
  String _token;
  String _createTime;
  String _endTime;


  User(this._id, this._email, this._token, this._createTime, this._endTime);

  factory User.fromJson(dynamic json) {
    return User(json['id'] as int, json['email'] as String,
        json['token'] as String,json['createTime'] as String,json['endTime'] as String);
  }
  int get id => _id;

  String get email => _email;

  String get token => _token;

  String get createTime => _createTime;

  String get endTime => _endTime;
}

