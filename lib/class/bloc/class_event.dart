import 'package:equatable/equatable.dart';
import '../models/class_model.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();
}

class LoadClassEvent extends ClassEvent {
  const LoadClassEvent();
  @override
  List<Object?> get props => [];
}

class CreateClassEvent extends ClassEvent {
  Class classModel;
  CreateClassEvent(this.classModel);
  @override
  List<Object?> get props => [classModel];
}

class UpdateClassEvent extends ClassEvent {
  Class classModel;
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