
import 'package:eaw/api_model/LoginProvider.dart';
import 'package:eaw/dto/LoginRequest.dart';

class LoginRepo{
  LoginProvider loginProvider = LoginProvider();
  Future checkLogin(LoginRequest loginRequest) async=> loginProvider.checkLogin(loginRequest);
}