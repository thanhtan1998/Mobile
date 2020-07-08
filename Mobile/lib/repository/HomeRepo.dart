import 'package:eaw/api_model/HomeProvider.dart';
import 'package:eaw/dto/HomeResponse.dart';

class HomeRepo {
  HomeProvider homeProvider = HomeProvider();

  Future<HomeResponse> getHome(String userToken, int userId) async {
  return await homeProvider.getHome(userToken, userId);
  }
}
