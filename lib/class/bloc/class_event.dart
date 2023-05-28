import 'package:equatable/equatable.dart';
import '../models/class_model.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();
}

class LoadSelectClassEvent extends ClassEvent {
  const LoadSelectClassEvent();
  @override
  List<Object?> get props => [];
}

class LoadManageClassEvent extends ClassEvent {
  const LoadManageClassEvent();
  @override
  List<Object?> get props => [];
}

class CreateClassEvent extends ClassEvent {
  classesForSelectModel classModel;
  CreateClassEvent(this.classModel);
  @override
  List<Object?> get props => [classModel];
}

class UpdateClassEvent extends ClassEvent {
  classesForSelectModel classModel;
  UpdateClassEvent(this.classModel);
  @override
  List<Object?> get props => [classModel];
}

class DeleteClassEvent extends ClassEvent {
  String id;
  DeleteClassEvent(this.id);
  @override
  List<Object?> get props => [id];
}