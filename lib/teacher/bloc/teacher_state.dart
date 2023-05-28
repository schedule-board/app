import 'package:equatable/equatable.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();
  @override
  List<Object?> get props => [];
}

class TeacherInitialState extends TeacherState {}

class TeachersOperationSuccess extends TeacherState {
  final List<dynamic> teachers;
  const TeachersOperationSuccess(this.teachers);
  @override
  List<Object?> get props => [teachers];
}

class TeacherOperationFailure extends TeacherState {
  final Object error;
  const TeacherOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}
