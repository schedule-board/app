import './bloc.dart';
import "package:flutter_bloc/flutter_bloc.dart";
abstract class ScheduleState {}

class ScheduleInitialState  extends ScheduleState {}

class ScheduleLoadingState extends ScheduleState {}



class ScheduleOperationSuccess extends ScheduleState {
  final List<dynamic> schedules;
  ScheduleOperationSuccess(this.schedules);
  @override
  List<Object?> get props => [schedules];
}

class ScheduleOperationFailureState extends ScheduleState {
  final Object error;
  ScheduleOperationFailureState(this.error);
  @override
  List<Object?> get props => [error];
}








/////////////////////////////

// class ScheduleLoaded extends ScheduleState {
//   final List<Schedule> schedules;

//   ScheduleLoaded(this.schedules);
// }

// class ScheduleErrorState extends ScheduleState {
//   final String message;

//   ScheduleErrorState(this.message);
// }





