import 'package:equatable/equatable.dart';
import '../models/class_model.dart';

abstract class ClassUpdateEvent extends Equatable {
  const ClassUpdateEvent();
}

class UpdateClassEvent extends ClassUpdateEvent {
  Map classs;
  String token;
  String? schoolId;
  String? classId;
  UpdateClassEvent(this.classs, this.classId, this.schoolId, this.token);
  @override
  List<Object?> get props => [classs];
}
