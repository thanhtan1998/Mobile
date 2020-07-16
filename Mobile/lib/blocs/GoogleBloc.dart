import 'package:eaw/dto/LoginRequest.dart';
import 'package:eaw/repository/GoogleRepo.dart';
import 'package:rxdart/rxdart.dart';

class GoogleBloc {
  GoogleRepo googleRepo = GoogleRepo();
  // ignore: close_sinks
  final data = PublishSubject<LoginRequest>();
  Observable<LoginRequest> get getLoginRequest => data.stream;

  signInGoogle() async {
    LoginRequest loginRequest = await googleRepo.signInGoogle();
    data.sink.add(loginRequest);
    return true;
  }

  signOutGoogle() async {
    await googleRepo.signOutGoogle();
  }

  checkLogin() async {
//    FirebaseUser user = await googleRepo.checkLogin();
//    data.sink.add(user);
  }
}

final googleBloc = GoogleBloc();
