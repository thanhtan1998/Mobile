import 'package:eaw/dto/User.dart';
import 'package:eaw/resource/urlEnum.dart';
import 'dart:convert';

class UserProvider {
  Future<List<User>> getInfor() async {
    final response =
        await BaseURL.client.get(BaseURL.baseURL + UrlUser.getUser);
    if (response.statusCode == BaseURL.successCode) {
      print(response.body.toString());
      Iterable result = jsonDecode(response.body);
     List<User> iterable = [];
//          List<User>.from(result).map((e) => User.fromJson(e)).toList();
      for (var u in result) {
        iterable.add(User.fromJson(u));
      }

//      for (User u in iterable) {
//        print(u.toString());
//      }
      return iterable;
    }
    return null;
  }
}
