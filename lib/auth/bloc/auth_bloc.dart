import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/auth/data_provider/auth_api_provider.dart';
import 'package:schedule/auth/models/user_model.dart';
import 'package:schedule/auth/repository/auth_repository.dart';
import 'package:schedule/auth/states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LoginAttemptEvent>((event, emit) async {
      AuthRepository(this).signIn(event.userEmail, event.password);
      emit(state.copyWith(isProcessing: true));
    });

    on<LoginSuccessEvent>((event, emit) {
      // set the token
      // set the user
      // set the school
      emit(state.copyWith(user: event.user, isProcessing: false, authFailed: false));
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
  LoginSuccessEvent({required this.user});
}

class LoginFailedEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class AuthProcessingStartEvent extends AuthEvent {}
