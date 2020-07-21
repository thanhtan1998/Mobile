import 'package:eaw/api_model/HomeProvider.dart';
import 'package:eaw/dto/HomeResponse.dart';
import 'package:eaw/dto/RequestQR.dart';

class HomeRepo {
  HomeProvider homeProvider = HomeProvider();

  Future<HomeResponse> getHome(String userToken, int userId) async {
    return await homeProvider.getHome(userToken, userId);
  }

  Future sendRequestAttendanceByQr(
      RequestQr requestQr, String userToken) async {
    return await homeProvider.sendRequestAttendanceByQr(requestQr, userToken);
  }
}
