import '../bloc/bloc.dart';
import '../data_provider/schedule_provider.dart';
import "../models/schedules_Amodel.dart";

class ScheduleRepository {
  final ScheduleProvider scheduleProvider;

  ScheduleRepository(this.scheduleProvider);

  Future<List<dynamic>> load(Map filter) async {
    return scheduleProvider.loadSchedules(filter);
  }

  Future<Schedule> update(Map schedule, String? scheduleId, token) async {
    return scheduleProvider.updateSchedule(schedule, scheduleId, token);
  }

  Future<dynamic> delete(String? scheduleId, token) async {
    return scheduleProvider.deleteSchedule(scheduleId, token);
  }
}
