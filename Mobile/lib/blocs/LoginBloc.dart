import 'package:eaw/dto/LoginRequest.dart';
import 'package:eaw/dto/LoginResponse.dart';
import 'package:eaw/repository/LoginRepo.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  LoginRepo loginRepo = LoginRepo();
  // ignore: close_sinks
  final data = BehaviorSubject<LoginResponse>();

  LoginResponse get getLoginResponse => data.value;

  checkLogin(LoginRequest loginRequest) async {
    LoginResponse loginResponse = await loginRepo.checkLogin(loginRequest);
    data.sink.add(loginResponse);
  }
}

final loginBloc = LoginBloc();
