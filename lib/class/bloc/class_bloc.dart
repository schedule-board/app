import 'package:flutter_bloc/flutter_bloc.dart';
import './class_event.dart';
import './class_state.dart';
import '../repository/class_repository.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassRepository classRepository;

  ClassBloc(this.classRepository) : super(ClassInitialState()) {
    on<LoadClassEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var classes = await classRepository.load("646a2b183748bfedb7cb7819");
        emit(ClassesOperationSuccess(classes));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });
  }
}
