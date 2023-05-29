import 'package:equatable/equatable.dart';
import '../models/course_model.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  String? schoolId;
  String? token;
  LoadCourseEvent(this.schoolId, this.token);
  @override
  List<Object?> get props => [];
}

class LoadOneCourseEvent extends CourseEvent {
  String? id;
  String? schoolId;
  String? token;
  LoadOneCourseEvent(this.schoolId, this.id, this.token);
  @override
  List<Object?> get props => [id];
}

class CreateCourseEvent extends CourseEvent {
  Map course;
  String? schoolId;
  String? token;
  CreateCourseEvent(this.course, this.schoolId, this.token);
  @override
  List<Object?> get props => [course];
}

class DeleteCourseEvent extends CourseEvent {
  String courseId;
  String schoolId;
  String? token;
  DeleteCourseEvent(this.courseId, this.schoolId, this.token);
  @override
  List<Object?> get props => [];
}
