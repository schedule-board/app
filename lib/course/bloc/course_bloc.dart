import "package:flutter_bloc/flutter_bloc.dart";
import './course_event.dart';
import './course_state.dart';
import '../repository/course_repository.dart';
import 'package:http/http.dart' as http;

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseRepository courseRepository;

  CourseBloc(this.courseRepository) : super(CourseInitialState()) {
    on<LoadCourseEvent>((event, emit) async {
      emit(CourseLoadingState());
      try {
        var courses = await courseRepository.load(
            http.Client(), event.schoolId!, event.token);
        emit(CoursesOperationSuccess(courses));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });

    on<LoadOneCourseEvent>((event, emit) async {
      emit(CourseLoadingState());
      try {
        var course = await courseRepository.loadOne(
            http.Client(), event.schoolId!, event.id, event.token);
        emit(OneCourseOperationSuccess(course));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });

    on<CreateCourseEvent>((event, emit) async {
      try {
        emit(CourseLoadingState());
        var course = await courseRepository.create(
            http.Client(), event.course, event.schoolId, event.token);
        emit(OneCourseOperationSuccess(course));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });

    on<DeleteCourseEvent>((event, emit) async {
      try {
        emit(CourseLoadingState());
        var x = await courseRepository.delete(
            http.Client(), event.courseId, event.schoolId, event.token);
        emit(DeleteCourseOperationSuccess(x));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });
  }
}
