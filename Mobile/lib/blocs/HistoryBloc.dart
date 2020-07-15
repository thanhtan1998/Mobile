import 'package:eaw/dto/HistoryResponse.dart';
import 'package:eaw/repository/HistoryRepo.dart';
import 'package:rxdart/rxdart.dart';

class HistoryBloc {
  HistoryRepo historyRepo = HistoryRepo();
  // ignore: close_sinks
  final data = PublishSubject<HistoryResponse>();
  PublishSubject<HistoryResponse> get getHistoryResponse => data.stream;

  getHistory(String userToken, int userId, DateTime startDate,
      DateTime endDate) async {
    HistoryResponse historyResponse =
        await historyRepo.getHistory(userToken, userId, startDate, endDate);
    data.sink.add(historyResponse);
  }
}

final HistoryBloc historyBloc = HistoryBloc();
