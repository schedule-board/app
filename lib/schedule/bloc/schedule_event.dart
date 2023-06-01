import 'package:equatable/equatable.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class LoadScheduleEvent extends ScheduleEvent {
  Map filter;
  LoadScheduleEvent(this.filter);
  @override
  List<Object?> get props => [];
}

class RanderSchedule extends ScheduleEvent {
  List<dynamic> schedules;
  RanderSchedule(this.schedules);
  @override
  List<Object?> get props => [];
}
