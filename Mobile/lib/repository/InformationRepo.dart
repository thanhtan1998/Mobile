import 'package:eaw/api_model/InformationProvider.dart';
import 'package:eaw/dto/InformationResponse.dart';

class InformationRepo {
  InformationProvider informationProvider = InformationProvider();

  Future<InformationResponse> getInformation(
      String userToken, int userId) async {
    return await informationProvider.getInformation(userToken, userId);
  }

  Future<InformationResponse> updateInformation(
      String userToken, int userId, String titleUpdate, Object value) async {
    return await informationProvider.updateInformation(
        userToken, userId, titleUpdate, value);
  }
}
