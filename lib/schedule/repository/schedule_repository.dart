import 'package:schedule/schedule/data_provider/schedule_local_provider.dart';

import '../bloc/bloc.dart';
import '../data_provider/schedule_api_provider.dart';
import "../models/schedules_Amodel.dart";

class ScheduleRepository {
  final ScheduleApiProvider scheduleApiProvider;
  final ScheduleLocalProvider scheduleLocalProvider = ScheduleLocalProvider();

  ScheduleRepository(this.scheduleApiProvider);

  Future<List<Schedule>> load(client, Map filter) async {
    // try {
    var schedules = await scheduleApiProvider.loadSchedules(client, filter);
    // for (var schedule in schedules) {
    //   scheduleLocalProvider.upsertSchedule(schedule.toJson());
    // // }
    return schedules;
    // } catch (e) {
    //   // fetch schedules from the local database
    //   // var schedules = scheduleLocalProvider.getAllSchedules();
    //   // return schedules;
    // }
  }

  Future<Schedule> update(
      client, Map schedule, String? scheduleId, token) async {
    return scheduleApiProvider.updateSchedule(
        client, schedule, scheduleId, token);
  }

  Future<dynamic> delete(client, String? scheduleId, token) async {
    return scheduleApiProvider.deleteSchedule(client, scheduleId, token);
  }
}
