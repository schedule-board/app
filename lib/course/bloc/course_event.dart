import 'package:equatable/equatable.dart';
import '../models/course_model.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  const LoadCourseEvent();
  @override
  List<Object?> get props => [];
}

class LoadOneCourseEvent extends CourseEvent {
  String? id;
  LoadOneCourseEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class CreateCourseEvent extends CourseEvent {
  Map course;
  String? schoolId;
  CreateCourseEvent(this.course, this.schoolId);
  @override
  List<Object?> get props => [course];
}

class DeleteCourseEvent extends CourseEvent {
  String courseId;
  String schoolId;
  DeleteCourseEvent(this.courseId, this.schoolId);
  @override
  List<Object?> get props => [];
}
