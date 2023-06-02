// class Schedule {
//   String scheduleId;
//   String courseName;
//   String startTime;
//   String endTime;
//   String dayOfTheWeek;
//   String schoolId;
//   String teacherId;
//   String classId;
//   String className;

//   Schedule(
//       {required this.scheduleId,
//       required this.courseName,
//       required this.startTime,
//       required this.endTime,
//       required this.dayOfTheWeek,
//       required this.schoolId,
//       required this.teacherId,
//       required this.classId,
//       required this.className});

//   factory Schedule.fromJson(Map<String, dynamic> json) {
//     return Schedule(
//       scheduleId: json["_id"],
//       courseName: json["course"]?? "corse_name",
//       startTime: json["startTime"]??"start",
//       endTime: json["endTime"]?? "end",
//       dayOfTheWeek: json["dayOfTheWeek"] ?? "day",
//       teacherId: json["teacher"]["_id"],
//       className: json["class"] ? json["class"]["class_name"] : "null",
//       classId: json["class"] ? json["class"]["_id"] : "null",
//       schoolId: json["school"]?? "school_id",
//     );
//   }
// }


// class ScheduleItem {
//   final String id;
//   final String course;
//   final String school;

//   final String dayOfTheWeek;
//   final String startTime;
//   final String endTime;
//   final String className;

//   ScheduleItem({
//     required this.id,
//     required this.course,
//     required this.school,
//     required this.dayOfTheWeek,
//     required this.startTime,
//     required this.endTime,
//     required this.className,
//   });

//   factory ScheduleItem.fromJson(Map<dynamic, dynamic> json) {
//     return ScheduleItem(
//       id: json['_id'],
//       course: json['course'],
//       school: json['school'],
//       dayOfTheWeek: json['dayOfTheWeek'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//       className:json["class"] != null ? json["class"]["class_name"] : "section",  
//     );
//   }
// }
