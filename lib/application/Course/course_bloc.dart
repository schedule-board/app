// import "package:flutter_bloc/flutter_bloc.dart";
// import './course_event.dart';
// import './course_state.dart';
// import '../../course/repository/course_repository.dart';
// import '../../course/models/course_model.dart';

// class CourseBloc extends Bloc<CourseEvent, CourseState> {
//   CourseRepository courseRepository;

//   CourseBloc(this.courseRepository) : super(CourseInitialState()) {
//     on<LoadCourseEvent>((event, emit) async {
//       emit(CourseLoadingState());
//       try {
//         var courses = await courseRepository.load("646a2b183748bfedb7cb7819");
//         emit(CoursesOperationSuccess(courses));
//       } catch (err) {
//         emit(CourseOperationFailure(err));
//       }
//     });
//   }
// }
