import "package:flutter_bloc/flutter_bloc.dart";
import './class_updateEvent.dart';
import './class_updateState.dart';
import '../repository/class_repository.dart';
import '../models/class_model.dart';
import 'package:http/http.dart' as http;

class ClassUpdateBloc extends Bloc<ClassUpdateEvent, ClassUpdateState> {
  ClassRepository classRepository;

  ClassUpdateBloc(this.classRepository) : super(ClassUpdateInitialState()) {
    on<UpdateClassEvent>((event, emit) async {
      emit(ClassUpdateLoadingState());
      try {
        var classs = await classRepository.updateClass(http.Client(),
            event.classs, event.classId, event.schoolId, event.token);
        emit(ClassUpdateOperationSuccess(classs));
      } catch (err) {
        emit(ClassUpdateOperationFailure(err));
      }
    });
  }
}
