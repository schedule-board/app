import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";

@immutable
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class LoadScheduleEvent extends ScheduleEvent {
  Map filter;
  LoadScheduleEvent(this.filter);
  @override
  List<Object?> get props => [];
}

class UpdateScheduleEvent extends ScheduleEvent {
  Map updatedschedule;
  String? secduleId;
  UpdateScheduleEvent(this.updatedschedule, this.secduleId);
  @override
  List<Object?> get props => [updatedschedule];
}

class DeleteScheduleEvent extends ScheduleEvent {
  String? scheduleId;
  DeleteScheduleEvent(this.scheduleId);
  @override
  List<Object?> get props => [];
}
