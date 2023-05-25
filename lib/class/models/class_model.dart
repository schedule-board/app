class classesForSelectModel {
  String classId;
  String className;
  List<dynamic> courseIds;

  classesForSelectModel({
    required this.classId,
    required this.className,
    required this.courseIds,
  });

  factory classesForSelectModel.fromJson(Map<dynamic, dynamic> json) {
    return classesForSelectModel(
      classId: json["id"],
      className: json["class_name"],
      courseIds: json["courses"],
    );
  }
}

class classesForManage {
  String classId;
  String className;
  List<dynamic> courseIds;

  classesForManage({
    required this.classId,
    required this.className,
    required this.courseIds,
  });
// Notes: since what the database is sending is not clear yet, I am just returning a dummy data for now.
//      I will update this later.

  factory classesForManage.fromJson(Map<dynamic, dynamic> json) {
    return classesForManage(
      classId: "id",
      className: "class_name",
      courseIds: ["course A", "course B", "course C"],
    );
  }
}
