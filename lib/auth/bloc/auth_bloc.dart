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

    on<LoginFailedEvent>((event, emit) {
      emit(state.copyWith(authFailed: true, isProcessing: false));
    });

    on<LogoutEvent>((event, emit) {
      emit(state.copyWith(user: null));
    });

    on<AuthProcessingStartEvent>((event, emit) {
      emit(state.copyWith(isProcessing: true, authFailed: false));
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

class LoginSuccessEvent extends AuthEvent {
  User user;
  School school;
  String token;

  LoginSuccessEvent({
    required this.user,
    required this.school,
    required this.token,
  });
}

class LoginFailedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthProcessingStartEvent extends AuthEvent {}
