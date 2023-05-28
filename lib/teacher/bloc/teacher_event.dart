import 'package:equatable/equatable.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();
}

class LoadTeacherEvent extends TeacherEvent {
  String schoolId;
  LoadTeacherEvent(this.schoolId);
  @override
  List<Object?> get props => [];
}
