import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";


@immutable
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class LoadScheduleEvent extends ScheduleEvent {
  const LoadScheduleEvent();
  @override
  List<Object?> get props => [];
}






