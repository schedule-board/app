import 'package:schedule/auth/models/user_model.dart';
import 'package:schedule/school/models/school_model.dart';

class AuthState {
  User? user;
  School? school;
  String? token;
  bool isProcessing;
  bool authFailed;
  AuthState({
    this.user,
    this.school,
    this.token,
    this.isProcessing = false,
    this.authFailed = false,
  });

  AuthState copyWith({
    User? user,
    School? school,
    String? token,
    bool? isProcessing,
    bool? authFailed,
  }) {
    return AuthState(
      user: user,
      school: school,
      token: token,
      isProcessing: isProcessing ?? this.isProcessing,
      authFailed: authFailed ?? this.authFailed,
    );
  }
}
