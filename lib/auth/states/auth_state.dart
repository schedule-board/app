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

  AuthState reset() {
    user = null;
    school = null;
    token = null;
    return copyWith();
  }

  AuthState copyWith({
    User? user,
    School? school,
    String? token,
    bool? isProcessing,
    bool? authFailed,
  }) {
    return AuthState(
      user: user ?? this.user,
      school: school ?? this.school,
      token: token ?? this.token,
      isProcessing: isProcessing ?? this.isProcessing,
      authFailed: authFailed ?? this.authFailed,
    );
  }
}

class InvitationState extends AuthState {
  String? invitationCode;
  InvitationState({
    super.user,
    super.school,
    super.token,
    super.isProcessing = false,
    super.authFailed = false,
    this.invitationCode,
  });
}

class InviteCoordinatorState extends InvitationState {
  InviteCoordinatorState({
    super.user,
    super.school,
    super.token,
    super.isProcessing = false,
    super.authFailed = false,
    super.invitationCode,
  });
}

class InviteTeacherState extends InvitationState {
  InviteTeacherState({
    super.user,
    super.school,
    super.token,
    super.isProcessing = false,
    super.authFailed = false,
    super.invitationCode,
  });
}
