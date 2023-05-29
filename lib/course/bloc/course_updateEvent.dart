import 'package:equatable/equatable.dart';
import '../models/course_model.dart';

abstract class CourseUpdateEvent extends Equatable {
  const CourseUpdateEvent();
}

class UpdateCourseEvent extends CourseUpdateEvent {
  Map course;
  String? schoolId;
  String? courseId;
  String token;
  UpdateCourseEvent(this.course, this.courseId, this.schoolId,this.token);
  @override
  List<Object?> get props => [course];
}
