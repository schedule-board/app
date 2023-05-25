import 'package:equatable/equatable.dart';
import '../models/class_model.dart';

abstract class ClassState extends Equatable {
  const ClassState();
  @override
  List<Object?> get props => [];
}

class ClassInitialState extends ClassState {}

class ClassLoadingState extends ClassState {}

class SelectClassOperationSuccess extends ClassState {
  final List<dynamic> classesToSelect;
  const SelectClassOperationSuccess(this.classesToSelect,);
  @override
  List<Object?> get props => [classesToSelect];
}

class ManageClassOperationSuccess extends ClassState {
  final List<dynamic> classesToManage;
  const ManageClassOperationSuccess(this.classesToManage,);
  @override
  List<Object?> get props => [classesToManage];
}

class ClassOperationFailure extends ClassState {
  final Object error;
  const ClassOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}




