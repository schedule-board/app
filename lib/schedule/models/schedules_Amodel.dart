class Schedule {
  String scheduleId;
  String courseName;
  String startTime;
  String endTime;
  String day;
  String schoolId;
  String? teacherName;
  String? teacherId;

  Schedule({
    required this.scheduleId,
    required this.courseName,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.schoolId,
    this.teacherName,
    this.teacherId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        scheduleId: json["id"],
        courseName: json["course"]["course_name"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        day: json["dayOfTheWeek"],
        teacherId: json["teacher"]["_id"],
        schoolId: json["school"]["id"],
        teacherName: json["teacher"]["user_name"]);
  }
}
