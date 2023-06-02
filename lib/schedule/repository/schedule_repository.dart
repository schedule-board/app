import '../bloc/bloc.dart';
import '../data_provider/schedule_provider.dart';
import "../models/schedules_Amodel.dart";

class ScheduleRepository {
  final ScheduleProvider scheduleProvider;

  ScheduleRepository(this.scheduleProvider);

  Future<List<dynamic>> load(client,Map filter) async {
    return scheduleProvider.loadSchedules(client,filter);
  }

  Future<Schedule> update(client,Map schedule, String? scheduleId, token) async {
    return scheduleProvider.updateSchedule(client,schedule, scheduleId, token);
  }

  Future<dynamic> delete(client,String? scheduleId, token) async {
    return scheduleProvider.deleteSchedule(client,scheduleId, token);
  }
}
