import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/data_provider/auth_api_provider.dart';
import 'package:schedule/auth/models/user_model.dart';

class AuthRepository {
  AuthBloc authBloc;

  AuthRepository(this.authBloc);

  Future<void> signIn(String userName, String password) async {
    try {
      var dataString = (await AuthApiProvider().signIn(userName, password))!['user'];
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(dataString as Map<String, dynamic>);
      User user = User.fromJson(dataMap);
      authBloc.add(LoginSuccessEvent(user: user));
    } catch (e) {
      authBloc.add(LoginFailedEvent());
    }
  }
}
