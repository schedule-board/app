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
      schoolName: json["school"] is Map
          ? json["school"]["school_name"]
          : json['schoolName'],
      classId: json["id"] ?? json["classId"],
      className: json["class_name"] ?? json["className"],
      courses: json["courses"],
    );
  }

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "className": className,
        "schoolName": schoolName,
        "isSelected": isSelected ? 1 : 0,
      };
}
