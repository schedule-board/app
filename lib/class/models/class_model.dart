class Class {
  String classId;
  String className;
  List<dynamic> courseIds;

  Class({
    required this.classId,
    required this.className,
    required this.courseIds,
  });

  factory Class.fromJson(Map<dynamic, dynamic> json) {
   

    return Class(
      classId: json["id"],
      className: json["class_name"],
      courseIds: json["courses"],
    );
  }
}
