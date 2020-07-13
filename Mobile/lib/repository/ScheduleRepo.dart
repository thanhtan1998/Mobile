import 'package:eaw/api_model/ScheduleProvider.dart';
import 'package:eaw/dto/ScheduleResponse.dart';

class ScheduleRepo {
  ScheduleProvider scheduleProvider = ScheduleProvider();

  Future<ScheduleResponse> getSchedule(String userToken, int userId,
      DateTime startDate, DateTime endDate) async {
    return await scheduleProvider.getSchedule(
        userToken, userId, startDate, endDate);
  }
}
