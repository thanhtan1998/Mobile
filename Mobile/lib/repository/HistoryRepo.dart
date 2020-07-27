import 'package:eaw/api_model/HistoryProvider.dart';
import 'package:eaw/dto/HistoryResponse.dart';

class HistoryRepo {
  HistoryProvider provider = HistoryProvider();
  Future<HistoryResponse> getHistory(String userToken, int userId,
      DateTime startDate, DateTime endDate) async {
    return await provider.getHistory(userToken, userId, startDate, endDate);
  }

  Future sendRequest(String userToken, int userId, String createTime,
      String content, String wifiName) async {
    return await provider.sendRequest(
        userToken, userId, createTime, content, wifiName);
  }
}
