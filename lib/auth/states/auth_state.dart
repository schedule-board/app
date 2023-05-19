class AuthState {
  String? userName;

  AuthState({this.userName});

  AuthState copyWith({String? userName}) {
    return AuthState(userName: userName ?? this.userName);
  }
}
