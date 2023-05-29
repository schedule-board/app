class Class {
  String classId;
  String className;
  String? schoolName;
  List<dynamic>? courses;
  bool isSelected = false;
  Class(
      {required this.classId,
      required this.className,
      required this.courses,
      required this.schoolName});

  factory Class.fromJson(Map<dynamic, dynamic> json) {
    return Class(
      schoolName: json["school"] is Map ? json["school"]["school_name"] : null,
      classId: json["id"],
      className: json["class_name"],
      courses: json["courses"],
    );
  }
}
