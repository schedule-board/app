class School {
  String id;
  String schoolName;
  String schoolEmail;
  String ownerId;

  School({
    required this.id,
    required this.schoolName,
    required this.schoolEmail,
    required this.ownerId,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json["_id"],
      schoolName: json["school_name"],
      schoolEmail: json["school_email"],
      ownerId: json["owner"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "school_name": schoolName,
      "school_email": schoolEmail,
      "owner": ownerId,
    };
  }
}
