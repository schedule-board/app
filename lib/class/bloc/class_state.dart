import 'package:equatable/equatable.dart';
import '../models/class_model.dart';

abstract class ClassState extends Equatable {
  const ClassState();
  @override
  List<Object?> get props => [];
}

class ClassInitialState extends ClassState {}

class ClassLoadingState extends ClassState {}


class ClassesOperationSuccess extends ClassState {
  final List<dynamic> classes;
  const ClassesOperationSuccess(this.classes);
  @override
  List<Object?> get props => [classes];
}


class ClassOperationFailure extends ClassState {
  final Object error;
  const ClassOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}
