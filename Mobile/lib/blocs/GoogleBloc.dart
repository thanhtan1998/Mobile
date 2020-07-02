import 'package:eaw/repository/GoogleRepo.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class GoogleBloc {
  GoogleRepo googleRepo = GoogleRepo();
  final data = PublishSubject<FirebaseUser>();
  Observable<FirebaseUser> get getUser => data.stream;

  signInGoogle() async {
    await googleRepo.signInGoogle();
    data.sink.add(common.firebaseUser);
  }

  signOutGoogle() async{
    await googleRepo.signOutGoogle();
  }

  checkLogin() async{
    FirebaseUser user = await googleRepo.checkLogin();
   data.sink.add(user);
  }

}
final googleBloc = GoogleBloc();