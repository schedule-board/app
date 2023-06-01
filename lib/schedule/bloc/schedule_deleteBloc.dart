import "package:flutter_bloc/flutter_bloc.dart";
import '../repository/schedule_repository.dart';
import 'package:equatable/equatable.dart';

class ScheduleDeleteBloc
    extends Bloc<ScheduleDeleteEvent, ScheduleDeleteState> {
  ScheduleRepository scheduleRepository;

  ScheduleDeleteBloc(this.scheduleRepository)
      : super(ScheduleDeleteInitialState()) {
    on<DeleteScheduleEvent>((event, emit) async {
      emit(ScheduleDeleteLoadingState());
      try {
        await scheduleRepository.delete(event.secduleId, event.token);
        emit(const ScheduleDeleteOperationSuccess());
      } catch (err) {
        emit(ScheduleDeleteOperationFailure(err));
      }
    });
  }
}

abstract class ScheduleDeleteEvent extends Equatable {
  const ScheduleDeleteEvent();
}

class DeleteScheduleEvent extends ScheduleDeleteEvent {
  String? secduleId;
  String token;
  DeleteScheduleEvent(this.secduleId, this.token);
  @override
  List<Object?> get props => [];
}

abstract class ScheduleDeleteState extends Equatable {
  const ScheduleDeleteState();
  @override
  List<Object?> get props => [];
}

class ScheduleDeleteInitialState extends ScheduleDeleteState {}

class ScheduleDeleteLoadingState extends ScheduleDeleteState {}

class ScheduleDeleteOperationSuccess extends ScheduleDeleteState {
  const ScheduleDeleteOperationSuccess();
  @override
  List<Object?> get props => [];
}

class ScheduleDeleteOperationFailure extends ScheduleDeleteState {
  final Object error;
  const ScheduleDeleteOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}
