import 'package:eaw/api_model/HistoryProvider.dart';
import 'package:eaw/dto/HistoryResponse.dart';

class HistoryRepo {
  Future<HistoryResponse> getHistory(String userToken, int userId,
      DateTime startDate, DateTime endDate) async {
    HistoryProvider provider = HistoryProvider();
    return await provider.getHistory(userToken, userId, startDate, endDate);
  }
}
