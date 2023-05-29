import "package:flutter_bloc/flutter_bloc.dart";
import './course_updateEvent.dart';
import './course_updateState.dart';
import '../repository/course_repository.dart';
import '../models/course_model.dart';

class CourseUpdateBloc extends Bloc<CourseUpdateEvent, CourseUpdateState> {
  CourseRepository courseRepository;

  CourseUpdateBloc(this.courseRepository) : super(CourseUpdateInitialState()) {
    on<UpdateCourseEvent>((event, emit) async {
      emit(CourseUpdateLoadingState());
      try {
        var course = await courseRepository.update(
            event.course, event.courseId, event.schoolId, event.token);
        emit(CourseUpdateOperationSuccess(course));
      } catch (err) {
        emit(CourseUpdateOperationFailure(err));
      }
    });
  }
}
