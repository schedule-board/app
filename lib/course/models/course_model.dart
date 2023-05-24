import './schedules_Amodel.dart';
import './user_model.dart';
import './school_models.dart';

class Course {
  final String courseId;
  String courseName;
  List<dynamic> schedules;
  String teacherName;
  String teacherId;
  String schoolName;

  Course({
    required this.courseId,
    required this.courseName,
    required this.schedules,
    required this.teacherName,
    required this.teacherId,
    required this.schoolName,
  });

  factory Course.fromJson(json) {
    print(json);
    var schedules = json["schedules"].map((schedule) {
      return Schedule(
        scheduleId: schedule["id"],
        courseName: json["course_name"],
        startTime: schedule["startTime"],
        endTime: schedule["endTime"],
        day: schedule["dayOfTheWeek"],
        schoolId: json["school"]["id"],
        classId: schedule["class"]["id"],
        className: schedule["class"]["class_name"],
        teacherId: schedule["teacher"]["_id"],
      );
    }).toList();

    ;

    return Course(
        courseId: json["id"],
        courseName: json["course_name"],
        schedules: schedules,
        teacherName: json["teacher"]["user_name"],
        teacherId: json["teacher"]["_id"],
        schoolName: json["school"]["school_name"]);
  }
}
