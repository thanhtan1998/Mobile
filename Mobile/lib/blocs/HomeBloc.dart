
import 'package:eaw/dto/HomeResponse.dart';
import 'package:eaw/repository/HomeRepo.dart';
import 'package:eaw/resource/CommonComponent.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{
  HomeRepo homeRepo = HomeRepo();
  // ignore: close_sinks
  final data = BehaviorSubject<HomeResponse>();
  HomeResponse get getHomeResponse => data.value;

  getHome(String userToken,int userId) async {
    HomeResponse homeResponse = await homeRepo.getHome(userToken, userId);
    data.sink.add(homeResponse);
  }
}
final HomeBloc homeBloc = HomeBloc();