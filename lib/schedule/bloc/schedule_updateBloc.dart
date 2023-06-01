import "package:flutter_bloc/flutter_bloc.dart";
import './schedule_updateEvent.dart';
import './schedule_updateState.dart';
import '../repository/schedule_repository.dart';


class ScheduleUpdateBloc extends Bloc<ScheduleUpdateEvent, ScheduleUpdateState> {
  ScheduleRepository scheduleRepository;

  ScheduleUpdateBloc(this.scheduleRepository) : super(ScheduleUpdateInitialState()) {
    on<UpdateScheduleEvent>((event, emit) async {
      emit(ScheduleUpdateLoadingState());
      try {
        var schedule = await scheduleRepository.update(event.updatedschedule, event.secduleId, event.token);
        emit(ScheduleUpdateOperationSuccess(schedule));
      } catch (err) {
        emit(ScheduleUpdateOperationFailure(err));
      }
    });
  }
}
