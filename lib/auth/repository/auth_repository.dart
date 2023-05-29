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
      var dataDynamic = (await AuthApiProvider().signIn(userName, password))!;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(dataDynamic as Map<String, dynamic>);
      // create the user
      User user = User.fromJson(dataMap['user']);
      School? school;
      if (user.role != 'student') {
        // create the school
        school = School.fromJson(dataMap['school']);
      }
      // extract the jwt
      String token = dataMap['token'];
      authBloc.add(LoginSuccessEvent(user: user, school: school, token: token));
    } catch (e) {
      authBloc.add(LoginFailedEvent());
    }
  }

  Future joinAsStudent(String userName, String userEmail, String password) async {
    try {
      // sigh up and fetch data
      var dataDynamic = (await AuthApiProvider().signUpAsStudent(userName: userName, userEmail: userEmail, password: password))!;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(dataDynamic as Map<String, dynamic>);
      // create the user
      User user = User.fromJson(dataMap['user']);
      // extract the jwt
      String token = dataMap['token'];
      authBloc.add(JoinAsStudentSuccessEvent(user: user, token: token));
    } catch (e) {
      authBloc.add(SignUpFailedEvent());
    }
  }

  Future joinAsOwner(String schoolName, String schoolEmail, String userName, String userEmail, String password) async {
    try {
      // sign up and fetch data
      var dataDynamic = (await AuthApiProvider().signUpAsOwner(
        schoolName: schoolName,
        schoolEmail: schoolEmail,
        userName: userName,
        userEmail: userEmail,
        password: password,
      ))!;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(dataDynamic as Map<String, dynamic>);
      // create the user
      User user = User.fromJson(dataMap['user']);
      School school = School.fromJson(dataMap['school']);
      // extract the jwt
      String token = dataMap['token'];
      authBloc.add(JoinAsOwnerSuccessEvent(user: user, school: school, token: token));
    } catch (e) {
      authBloc.add(SignUpFailedEvent());
    }
  }

  Future joinWithCode(String code, String userName, String userEmail, String password) async {
    try {
      // sign up and fetch data
      var dataDynamic = (await AuthApiProvider().signUpWithCode(
        code: code,
        userName: userName,
        userEmail: userEmail,
        password: password,
      ))!;
      Map<String, dynamic> dataMap = Map<String, dynamic>.from(dataDynamic as Map<String, dynamic>);
      // create the user
      User user = User.fromJson(dataMap['user']);
      School school = School.fromJson(dataMap['school']);
      // extract the jwt
      String token = dataMap['token'];
      authBloc.add(JoinWithCodeSuccessEvent(user: user, school: school, token: token));
    } catch (e) {
      authBloc.add(SignUpFailedEvent());
    }
  }

  getInvitationCode({required String schoolId, required bool forTeacher}) async {
    String invitationCode;
    if (forTeacher) {
      invitationCode = (await AuthApiProvider().getInvitationCodeForTeacher(schoolId))!;
    } else {
      invitationCode = (await AuthApiProvider().getInvitationCodeForCoordinator(schoolId))!;
    }
    return invitationCode;
  }
}
