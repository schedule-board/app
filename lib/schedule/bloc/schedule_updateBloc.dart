import "package:flutter_bloc/flutter_bloc.dart";
import './schedule_updateEvent.dart';
import './schedule_updateState.dart';
import '../repository/schedule_repository.dart';
import 'package:http/http.dart' as http;


class ScheduleUpdateBloc extends Bloc<ScheduleUpdateEvent, ScheduleUpdateState> {
  ScheduleRepository scheduleRepository;

  ScheduleUpdateBloc(this.scheduleRepository) : super(ScheduleUpdateInitialState()) {
    on<UpdateScheduleEvent>((event, emit) async {
      emit(ScheduleUpdateLoadingState());
      try {
        var schedule = await scheduleRepository.update(http.Client(),event.updatedschedule, event.secduleId, event.token);
        emit(ScheduleUpdateOperationSuccess(schedule));
      } catch (err) {
        emit(ScheduleUpdateOperationFailure(err));
      }
    });
  }
}
