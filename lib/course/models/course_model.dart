import '../../schedule/models/schedules_Amodel.dart';
import '../../auth/models/user_model.dart';

class Course {
  final String courseId;
  String courseName;
  List<dynamic>? schedules;
  String? teacherName;
  String teacherId;
  String? schoolName;

  Course({
    required this.courseId,
    required this.courseName,
    this.schedules,
    this.teacherName,
    required this.teacherId,
    this.schoolName,
  });

  factory Course.fromJson(json) {
    List? schedules;

    if (json["schedules"] != null) {
      schedules = json["schedules"].map((schedule) {
        return Schedule(
          scheduleId: schedule["id"],
          courseName: json["course_name"],
          startTime: schedule["startTime"],
          endTime: schedule["endTime"],
          day: schedule["dayOfTheWeek"],
          schoolId: json["school"] is String ? json["school"] : json["school"]["id"],
          teacherId: json["teacher"] is String ? json["teacher"] : json["teacher"]["_id"],
        );
      }).toList();
    }

    return Course(
        courseId: json["id"],
        courseName: json["course_name"],
        schedules: schedules,
        teacherName: json["teacher"] is String ? null : json["teacher"]["user_name"],
        teacherId: json["teacher"] is String ? json["teacher"] : json["teacher"]["_id"],
        schoolName: json["school"] is String ? null : json["school"]["school_name"]);
  }

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseName": courseName,
        "classId": schedules,
        "teacherName": teacherName,
        "teacherId": teacherId,
        "schoolName": schoolName,
      };
}
