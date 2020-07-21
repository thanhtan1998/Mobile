import 'package:eaw/dto/HomeResponse.dart';
import 'package:eaw/dto/RequestQR.dart';
import 'package:eaw/repository/HomeRepo.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  HomeRepo homeRepo = HomeRepo();
  // ignore: close_sinks
  final data = PublishSubject<HomeResponse>();
  PublishSubject<HomeResponse> get getHomeResponse => data.stream;

  getHome(String userToken, int userId) async {
    HomeResponse homeResponse = await homeRepo.getHome(userToken, userId);
    data.sink.add(homeResponse);
  }

  Future sendRequestAttendanceByQr(
      RequestQr requestQr, String userToken) async {
    return await homeRepo.sendRequestAttendanceByQr(requestQr, userToken);
  }
}

final HomeBloc homeBloc = HomeBloc();
