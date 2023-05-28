class Teacher {
  String teacherId;
  String teacherName;

  Teacher({required this.teacherId, required this.teacherName});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      teacherId: json["_id"],
      teacherName: json["user_name"],
    );
  }
}
