import 'package:schedule/domain/auth/user_rol.dart';

class User {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final Role role;

  User({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.role,
  });
}
