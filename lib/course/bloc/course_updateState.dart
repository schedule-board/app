import 'package:equatable/equatable.dart';
import '../models/course_model.dart';

abstract class CourseUpdateState extends Equatable {
  const CourseUpdateState();
  @override
  List<Object?> get props => [];
}

class CourseUpdateInitialState extends CourseUpdateState {}

class CourseUpdateLoadingState extends CourseUpdateState {}

class CourseUpdateOperationSuccess extends CourseUpdateState {
  final Course course;
  const CourseUpdateOperationSuccess(this.course);
  @override
  List<Object?> get props => [course];
}

class CourseUpdateOperationFailure extends CourseUpdateState {
  final Object error;
  const CourseUpdateOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}
