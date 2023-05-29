import 'package:equatable/equatable.dart';
import '../models/class_model.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();
}

class LoadClassesEvent extends ClassEvent {
  String schoolId;
  String token;
  LoadClassesEvent(this.schoolId, this.token);
  @override
  List<Object?> get props => [];
}

class LoadAllClassesEvent extends ClassEvent {
  String token;
  LoadAllClassesEvent(this.token);
  @override
  List<Object?> get props => [];
}

class LoadOneClassEvent extends ClassEvent {
  String token;
  String? classid;
  String? schoolId;
  LoadOneClassEvent(this.classid, this.schoolId, this.token);
  @override
  List<Object?> get props => [];
}

class CreateClassEvent extends ClassEvent {
  String token;
  Map classs;
  String? schoolId;
  CreateClassEvent(this.classs, this.schoolId, this.token);
  @override
  List<Object?> get props => [classs];
}

class DeleteClassEvent extends ClassEvent {
  String token;
  String classId;
  String schoolId;
  DeleteClassEvent(this.classId, this.schoolId, this.token);
  @override
  List<Object?> get props => [];
}
