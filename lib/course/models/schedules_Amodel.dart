class Schedule {
  String scheduleId;
  String courseName;
  String startTime;
  String endTime;
  String day;
  String schoolId;
  String teacherId;
  String? classId;
  String? className;

  Schedule(
      {required this.scheduleId,
      required this.courseName,
      required this.startTime,
      required this.endTime,
      required this.day,
      required this.schoolId,
      required this.teacherId,
      this.classId,
      this.className});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json["id"],
      courseName: json["course"]["course_name"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      day: json["day"],
      teacherId: json["teacher"]["teacherId"],
      className: json["class"] ? json["class"]["class_name"] : "null",
      classId: json["class"] ? json["class"]["id"] : "null",
      schoolId: json["school"]["id"],
    );
  }
}
