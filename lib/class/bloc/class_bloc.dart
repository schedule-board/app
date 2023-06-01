import "package:flutter_bloc/flutter_bloc.dart";
import './class_event.dart';
import './class_state.dart';
import '../repository/class_repository.dart';
import '../models/class_model.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassRepository classRepository;

  ClassBloc(this.classRepository) : super(ClassInitialState()) {
    on<LoadClassesEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var courses = await classRepository.loadClassesOfSchool(event.schoolId, event.token);
        emit(ClassesOperationSuccess(courses));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<LoadAllClassesEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var courses = await classRepository.loadAllClasses(event.token);
        emit(ClassesOperationSuccess(courses));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<LoadOneClassEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var classs = await classRepository.loadSingleClass(event.classid!, event.schoolId, event.token);
        emit(OneClassOperationSuccess(classs));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<CreateClassEvent>((event, emit) async {
      try {
        emit(ClassLoadingState());
        var classs = await classRepository.createClass(event.classs, event.schoolId, event.token);
        emit(OneClassOperationSuccess(classs));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<DeleteClassEvent>((event, emit) async {
      try {
        emit(ClassLoadingState());
        var x = await classRepository.deleteClass(event.classId, event.schoolId, event.token);
        emit(DeleteClassOperationSuccess(x));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });
  }
}
