import 'package:flutter_bloc/flutter_bloc.dart';
import './class_event.dart';
import './class_state.dart';
import '../repository/class_repository.dart';
import '../models/class_model.dart';

class SelectClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassRepository classRepository;

  SelectClassBloc(this.classRepository) : super(ClassInitialState()) {
    on<LoadSelectClassEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var classesToSelect = await classRepository.loadClassesForSelect();

        emit(SelectClassOperationSuccess(classesToSelect));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });
  }
}

class ManageClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassRepository classRepository;

  ManageClassBloc(this.classRepository) : super(ClassInitialState()) {
    on<LoadManageClassEvent>((event, emit) async {
      emit(ClassLoadingState());
      try {
        var ClassesToManage = await classRepository
            .loadClassesForManage("646a2b183748bfedb7cb7819");

        emit(ManageClassOperationSuccess(ClassesToManage));
      } catch (err) {
        emit(ClassOperationFailure(err));
      }
    });
  }
}

class CreateClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassRepository classRepository;

  CreateClassBloc(this.classRepository) : super(ClassInitialState()) {
    on<CreateClassEvent>(
      (event, emit) async {
        emit(ClassLoadingState());
        try {
          // I wil figure out this tomorrow ,
          var createdClass = await classRepository.createClass("646a2b183748bfedb7cb7819",data)
        }

      },
    );
  }
}
