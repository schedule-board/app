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





// class CreateScheduleEvent extends ScheduleEvent {
//   final Schedule schedule;
//   const CreateScheduleEvent(this.schedule);
//   @override
//   List<Object?> get props => [schedule];
// }

// class UpdateScheduleEvent extends ScheduleEvent {
//   final Schedule schedule;
//   const UpdateScheduleEvent(this.schedule);
//   @override
//   List<Object?> get props => [schedule];
// }

// class DeleteScheduleEvent extends ScheduleEvent {
//   final String id;
//   const DeleteScheduleEvent(this.id);
//   @override
//   List<Object?> get props => [id];
// }




class Schedule {
  String scheduleId;
  String courseName;
  String startTime;
  String endTime;
  String day;
  String schoolId;
  String teacherId;
  String classId;
  String className;

  Schedule(
      {required this.scheduleId,
      required this.courseName,
      required this.startTime,
      required this.endTime,
      required this.day,
      required this.schoolId,
      required this.teacherId,
      required this.classId,
      required this.className});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json["id"],
      courseName: json["course"]["course_name"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      day: json["day"],
      teacherId: json["teacher"]["teacherId"],
      className: json["class"] ? json["class"]["class_name"] : "null",
      classId: json["class"] ? json["class"]["id"] : "null",
      schoolId: json["school"]["id"],
    );
  }
}
