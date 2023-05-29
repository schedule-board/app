import 'package:equatable/equatable.dart';
import '../models/class_model.dart';

abstract class ClassUpdateState extends Equatable {
  const ClassUpdateState();
  @override
  List<Object?> get props => [];
}

class ClassUpdateInitialState extends ClassUpdateState {}

class ClassUpdateLoadingState extends ClassUpdateState {}

class ClassUpdateOperationSuccess extends ClassUpdateState {
  final Class classs;
  const ClassUpdateOperationSuccess(this.classs);
  @override
  List<Object?> get props => [classs];
}

class ClassUpdateOperationFailure extends ClassUpdateState {
  final Object error;
  const ClassUpdateOperationFailure(this.error);
  @override
  List<Object?> get props => [error];
}
