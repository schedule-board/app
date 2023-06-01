import 'package:equatable/equatable.dart';

abstract class ScheduleUpdateEvent extends Equatable {
  const ScheduleUpdateEvent();
}

class UpdateScheduleEvent extends ScheduleUpdateEvent {
  Map updatedschedule;
  String? secduleId;
  String token;
  UpdateScheduleEvent(this.updatedschedule, this.secduleId, this.token);
  @override
  List<Object?> get props => [updatedschedule];
}
