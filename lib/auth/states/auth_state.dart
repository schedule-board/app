import 'package:schedule/auth/models/user_model.dart';

class AuthState {
  User? user;
  bool isProcessing;
  bool authFailed;
  AuthState({
    this.user,
    this.isProcessing = false,
    this.authFailed = false,
  });

  AuthState copyWith({
    User? user,
    bool? isProcessing,
    bool? authFailed,
  }) {
    return AuthState(
      user: user ?? this.user,
      isProcessing: isProcessing ?? this.isProcessing,
      authFailed: authFailed ?? this.authFailed,
    );
  }
}
