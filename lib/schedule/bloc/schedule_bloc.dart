import "package:flutter_bloc/flutter_bloc.dart";
import './bloc.dart';
import '../repository/schedule_repository.dart';
import 'package:http/http.dart' as http;

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleRepository scheduleRepository;

  ScheduleBloc(this.scheduleRepository) : super(ScheduleInitialState()) {
    on<LoadScheduleEvent>((event, emit) async {
      emit(ScheduleLoadingState());
      try {
        var schedules = await scheduleRepository.load(http.Client(),event.filter);
        emit(ScheduleOperationSuccess(schedules));
      } catch (err) {
        emit(ScheduleOperationFailureState(err));
      }
    });

    on<RanderSchedule>((event, emit) async {
      emit(ScheduleOperationSuccess(event.schedules));
    });
  }
}
