import './user_model.dart';

class School {
  String schoolId;
  String schoolName;
  String schoolEmail;

  School(
      {required this.schoolId,
      required this.schoolName,
      required this.schoolEmail});

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      schoolId: json["id"],
      schoolName: json[" school_name"],
      schoolEmail: json["school_email"],
    );
  }
}
