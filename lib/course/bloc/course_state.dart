import 'package:equatable/equatable.dart';
import '../models/course_model.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object?> get props => [];
}

class CourseInitialState extends CourseState {}

class CourseLoadingState extends CourseState {}

class CoursesOperationSuccess extends CourseState {
  final List<dynamic> courses;
  const CoursesOperationSuccess(this.courses);
  @override
  List<Object?> get props => [courses];
}

class OneCourseOperationSuccess extends CourseState {
  final Course course;
  const OneCourseOperationSuccess(this.course);
  @override
  List<Object?> get props => [course];
}

class DeleteCourseOperationSuccess extends CourseState {
  final bool x;
  const DeleteCourseOperationSuccess(this.x);
  @override
  List<Object?> get props => [x];
}

class CourseOperationFailure extends CourseState {
  final Object error;
  const CourseOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}
