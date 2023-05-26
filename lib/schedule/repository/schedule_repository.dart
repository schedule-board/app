import '../bloc/bloc.dart';
import '../data_provider/schedule_provider.dart';

class ScheduleRepository {
  final ScheduleProvider scheduleProvider;

  ScheduleRepository(this.scheduleProvider);

  Future<List<dynamic>> load(String schoolId) async {
    return scheduleProvider.loadSchedule(schoolId);
  }
}
