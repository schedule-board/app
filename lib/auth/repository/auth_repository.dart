import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/data_provider/auth_api_provider.dart';
import 'package:schedule/auth/models/user_model.dart';
import 'package:schedule/school/models/school_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthBloc authBloc;

  AuthRepository(this.authBloc);

  Future<void> signIn(String userName, String password) async {
    try {
      // sign in and fetch the data
      var dataString = (await AuthApiProvider().signIn(userName, password))!;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(dataString as Map<String, dynamic>);
      // create the user
      User user = User.fromJson(dataMap['user']);
      // create the school
      School school = School.fromJson(dataMap['school']);
      // extract the jwt
      String token = dataMap['token'];
      authBloc.add(LoginSuccessEvent(user: user, school: school, token: token));
    } catch (e) {
      authBloc.add(LoginFailedEvent());
    }
  }
}
