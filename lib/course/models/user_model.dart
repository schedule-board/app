import './school_models.dart';

class User {
  String userId;
  String userName;
  String userEmail;
  String role;

  User({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json["id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        role: json["role"]);
  }
}
