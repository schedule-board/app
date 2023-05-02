import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<UserLogInEvent>((event, emit) {
      emit(state.copyWith(userName: "Andy"));
    });

    on<UserLogOutEvent>((event, emit) {
      emit(state.copyWith(userName: null));
    });
  }
}

abstract class AuthEvent {}

class UserLogInEvent extends AuthEvent {
  String newUserName;

  UserLogInEvent({required this.newUserName});
}

class UserLogOutEvent extends AuthEvent {}
