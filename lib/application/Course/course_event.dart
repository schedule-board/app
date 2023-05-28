import 'package:equatable/equatable.dart';
import '../../course/models/course_model.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  const LoadCourseEvent();
  @override
  List<Object?> get props => [];
}

class CreateCourseEvent extends CourseEvent {
  Course course;
  CreateCourseEvent(this.course);
  @override
  List<Object?> get props => [course];
}

class UpdateCourseEvent extends CourseEvent {
  Course course;
  UpdateCourseEvent(this.course);
  @override
  List<Object?> get props => [course];
}

class DeleteCourseEvent extends CourseEvent {
  String id;
  DeleteCourseEvent(this.id);
  @override
  List<Object?> get props => [id];
}
