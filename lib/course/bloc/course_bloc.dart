import "package:flutter_bloc/flutter_bloc.dart";
import './course_event.dart';
import './course_state.dart';
import '../repository/course_repository.dart';
import '../models/course_model.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseRepository courseRepository;

  CourseBloc(this.courseRepository) : super(CourseInitialState()) {
    on<LoadCourseEvent>((event, emit) async {
      emit(CourseLoadingState());
      try {
        var courses = await courseRepository.load("646a2b183748bfedb7cb7819");
        emit(CoursesOperationSuccess(courses));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });

    on<LoadOneCourseEvent>((event, emit) async {
      emit(CourseLoadingState());
      try {
        var course = await courseRepository.loadOne(
            "646a2b183748bfedb7cb7819", event.id);
        emit(OneCourseOperationSuccess(course));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });

    on<CreateCourseEvent>((event, emit) async {
      try {
        emit(CourseLoadingState());
        var course =
            await courseRepository.create(event.course, event.schoolId);
        emit(OneCourseOperationSuccess(course));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });

    on<DeleteCourseEvent>((event, emit) async {
      try {
        emit(CourseLoadingState());
        var x = await courseRepository.delete(event.courseId, event.schoolId);
        emit(DeleteCourseOperationSuccess(x));
      } catch (err) {
        emit(CourseOperationFailure(err));
      }
    });
  }
}
