import 'dart:io';

import 'package:flutter/foundation.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import './class_event.dart';
import './class_state.dart';
import '../repository/class_repository.dart';
import '../models/class_model.dart';
import 'package:http/http.dart' as http;
class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassRepository classRepository;

  ClassBloc(this.classRepository) : super(ClassInitialState()) {
    on<LoadClassesEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var courses = await classRepository.loadClassesOfSchool(http.Client(),event.schoolId, event.token);
        emit(ClassesOperationSuccess(courses));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<LoadAllClassesEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var courses = await classRepository.loadAllClasses(http.Client(),event.token);
        emit(ClassesOperationSuccess(courses));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<LoadOneClassEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var classs = await classRepository.loadSingleClass(http.Client(),event.classid!, event.schoolId, event.token);
        emit(OneClassOperationSuccess(classs));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<CreateClassEvent>((event, emit) async {
      try {
        emit(ClassLoadingState());
        var classs = await classRepository.createClass(http.Client(),event.classs, event.schoolId, event.token);
        emit(OneClassOperationSuccess(classs));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });

    on<DeleteClassEvent>((event, emit) async {
      try {
        emit(ClassLoadingState());
        var x = await classRepository.deleteClass(http.Client(),event.classId, event.schoolId, event.token);
        emit(DeleteClassOperationSuccess(x));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });
  }
}
