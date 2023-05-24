import './schedules_Amodel.dart';
import './course_model.dart';
import './school_models.dart';

class Class {
  String classId;
  String className;
  List<String> courseIds;

  Class({
    required this.classId,
    required this.className,
    required this.courseIds,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      classId: json["id"],
      className: json["class_name"],
      courseIds: json["courses"],
    );
  }
}
