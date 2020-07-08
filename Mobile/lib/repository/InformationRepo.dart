import 'package:eaw/api_model/InformationProvider.dart';
import 'package:eaw/dto/InformationResponse.dart';

class InformationRepo{
  InformationProvider informationProvider = InformationProvider();

  Future<InformationResponse> getInformation(String userToken, int userId) async {
    return await informationProvider.getInformation(userToken, userId);
  }
}