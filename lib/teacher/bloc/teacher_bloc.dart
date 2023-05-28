import "package:flutter_bloc/flutter_bloc.dart";
import "../repository/teacher_repository.dart";
import './teacher_event.dart';
import './teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherRepository teacherRepository;

  TeacherBloc(this.teacherRepository) : super(TeacherInitialState()) {
    on<LoadTeacherEvent>((event, emit) async {
      try {
        var teacher = await teacherRepository.load("646a2b183748bfedb7cb7819");

        emit(TeachersOperationSuccess(teacher));
      } catch (err) {
        emit(TeacherOperationFailure(err));
      }
    });
  }
}
