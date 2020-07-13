import 'package:eaw/dto/ScheduleResponse.dart';
import 'package:eaw/repository/ScheduleRepo.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleBloc {
  ScheduleRepo scheduleProvider = ScheduleRepo();
  // ignore: close_sinks
  final data = PublishSubject<ScheduleResponse>();
  PublishSubject<ScheduleResponse> get getHomeResponse => data.stream;

  getSchedule(String userToken, int userId, DateTime startDate,
      DateTime endDate) async {
    ScheduleResponse scheduleResponse = await scheduleProvider.getSchedule(
        userToken, userId, startDate, endDate);
    data.sink.add(scheduleResponse);
  }
}

final ScheduleBloc scheduleBloc = ScheduleBloc();
