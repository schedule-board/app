import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/auth/data_provider/auth_api_provider.dart';
import 'package:schedule/auth/models/user_model.dart';
import 'package:schedule/auth/repository/auth_repository.dart';
import 'package:schedule/auth/states/auth_state.dart';
import 'package:schedule/school/models/school_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LoginAttemptEvent>((event, emit) async {
      AuthRepository(this).signIn(event.userEmail, event.password);
      emit(state.copyWith(isProcessing: true));
    });

    on<JoinAsStudentAttemptEvent>((event, emit) async {
      AuthRepository(this).joinAsStudent(event.userName, event.userEmail, event.password);
      emit(state.copyWith(isProcessing: true));
    });

    on<JoinAsOwnerAttemptEvent>((event, emit) async {
      AuthRepository(this).joinAsOwner(event.schoolName, event.schoolEmail, event.userName, event.userEmail, event.password);
      emit(state.copyWith(isProcessing: true));
    });

    on<LoginSuccessEvent>((event, emit) async {
      // set the jwt token in the shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', event.token);
      emit(state.copyWith(
        user: event.user,
        school: event.school,
        token: event.token,
        isProcessing: false,
        authFailed: false,
      ));
    });

    on<JoinAsStudentSuccessEvent>((event, emit) async {
      // set the jwt token in the shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', event.token);
      emit(state.copyWith(
        user: event.user,
        token: event.token,
        isProcessing: false,
        authFailed: false,
      ));
    });

    on<JoinAsOwnerSuccessEvent>((event, emit) async {
      // set the jwt token in the shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', event.token);
      emit(state.copyWith(
        user: event.user,
        token: event.token,
        isProcessing: false,
        authFailed: false,
      ));
    });

    on<LoginFailedEvent>((event, emit) {
      emit(state.copyWith(authFailed: true, isProcessing: false));
    });

    on<SignUpFailedEvent>((event, emit) {
      emit(state.copyWith(authFailed: true, isProcessing: false));
    });

    on<LogoutEvent>((event, emit) {
      // let's remove the token from the shared preferences
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove('token');
      });
      emit(state.reset());
    });

    on<AuthProcessingStartEvent>((event, emit) {
      emit(state.copyWith(isProcessing: true, authFailed: false));
    });

    on<InviteCoordinatorEvent>((event, emit) async {
      emit(state.copyWith(isProcessing: true));
      String invitationCode = await AuthRepository(this).getInvitationCode(schoolId: event.schoolId, forTeacher: false);
      emit(InviteCoordinatorState(
        user: state.user,
        school: state.school,
        token: state.token,
        invitationCode: invitationCode,
      ));
    });

    on<InviteTeacherEvent>((event, emit) async {
      emit(state.copyWith(isProcessing: true));
      String invitationCode = await AuthRepository(this).getInvitationCode(schoolId: event.schoolId, forTeacher: true);
      emit(InviteTeacherState(
        user: state.user,
        school: state.school,
        token: state.token,
        invitationCode: invitationCode,
      ));
    });
  }
}

abstract class AuthEvent {}

class UserLogInSuccessEvent extends AuthEvent {
  User newUser;

  UserLogInSuccessEvent({required this.newUser});
}

class LoginAttemptEvent extends AuthEvent {
  String userEmail;
  String password;

  LoginAttemptEvent({required this.userEmail, required this.password});
}

class JoinAsStudentAttemptEvent extends AuthEvent {
  String userName;
  String userEmail;
  String password;

  JoinAsStudentAttemptEvent({required this.userName, required this.userEmail, required this.password});
}

class JoinAsOwnerAttemptEvent extends AuthEvent {
  String schoolName;
  String schoolEmail;
  String userName;
  String userEmail;
  String password;

  JoinAsOwnerAttemptEvent({
    required this.schoolName,
    required this.schoolEmail,
    required this.userName,
    required this.userEmail,
    required this.password,
  });
}

class LoginSuccessEvent extends AuthEvent {
  User user;
  School? school;
  String token;

  LoginSuccessEvent({
    required this.user,
    required this.school,
    required this.token,
  });
}

class JoinAsStudentSuccessEvent extends AuthEvent {
  User user;
  String token;

  JoinAsStudentSuccessEvent({
    required this.user,
    required this.token,
  });
}

class JoinAsOwnerSuccessEvent extends AuthEvent {
  User user;
  School school;
  String token;

  JoinAsOwnerSuccessEvent({
    required this.user,
    required this.school,
    required this.token,
  });
}

class LoginFailedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class SignUpFailedEvent extends AuthEvent {}

class AuthProcessingStartEvent extends AuthEvent {}

class InviteCoordinatorEvent extends AuthEvent {
  String schoolId;
  InviteCoordinatorEvent(this.schoolId);
}

class InviteTeacherEvent extends AuthEvent {
  String schoolId;
  InviteTeacherEvent(this.schoolId);
}
