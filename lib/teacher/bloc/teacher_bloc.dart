import "package:flutter_bloc/flutter_bloc.dart";
import "../repository/teacher_repository.dart";
import './teacher_event.dart';
import './teacher_state.dart';
import 'package:http/http.dart' as http;

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherRepository teacherRepository;

  TeacherBloc(this.teacherRepository) : super(TeacherInitialState()) {
    on<LoadTeacherEvent>((event, emit) async {
      try {
        var teacher =
            await teacherRepository.load(http.Client(), event.schoolId);
        emit(TeachersOperationSuccess(teacher));
      } catch (err) {
        emit(TeacherOperationFailure(err));
      }
    });
  }
}
