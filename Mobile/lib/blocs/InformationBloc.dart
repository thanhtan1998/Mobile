import 'package:eaw/dto/InformationResponse.dart';
import 'package:eaw/repository/InformationRepo.dart';
import 'package:rxdart/rxdart.dart';

class InformationBloc {
  InformationRepo informationRepo = InformationRepo();
  // ignore: close_sinks
  final data = PublishSubject<InformationResponse>();
  PublishSubject<InformationResponse> get getInformationResponse => data.stream;

  getInformation(String userToken, int userId) async {
    InformationResponse informationResponse =
        await informationRepo.getInformation(userToken, userId);
    data.sink.add(informationResponse);
  }

  updateInformation(
      String userToken, int userId, String titleUpdate, Object value) async {
    InformationResponse informationResponse = await informationRepo
        .updateInformation(userToken, userId, titleUpdate, value);
    data.sink.add(informationResponse);
  }
}

final InformationBloc informationBloc = InformationBloc();
