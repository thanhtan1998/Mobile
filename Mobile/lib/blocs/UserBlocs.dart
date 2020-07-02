import 'package:eaw/dto/User.dart';
import 'package:eaw/repository/UserRepo.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final repo = UserRepo();
  // ignore: close_sinks
  final fetch = PublishSubject<List<User>>();
  Observable<List<User>> get listUser => fetch.stream;

  fetchUser() async {
    List<User> listUser = await repo.getInfor();
    fetch.sink.add(listUser);
  }

}
final userBloc = UserBloc();
