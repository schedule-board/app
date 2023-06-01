import 'package:equatable/equatable.dart';
import '../models/schedules_Amodel.dart';

abstract class ScheduleUpdateState extends Equatable {
  const ScheduleUpdateState();
  @override
  List<Object?> get props => [];
}

class ScheduleUpdateInitialState extends ScheduleUpdateState {}

class ScheduleUpdateLoadingState extends ScheduleUpdateState {}

class ScheduleUpdateOperationSuccess extends ScheduleUpdateState {
  final Schedule schedule;
  const ScheduleUpdateOperationSuccess(this.schedule);
  @override
  List<Object?> get props => [schedule];
}

class ScheduleUpdateOperationFailure extends ScheduleUpdateState {
  final Object error;
  const ScheduleUpdateOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}
