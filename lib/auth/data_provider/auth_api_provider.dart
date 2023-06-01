import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiProvider {
  Future<Map?> signIn(
      http.Client client, String userEmail, String password) async {
    var uri = Uri.http('localhost:4000', '/api/v1/users/login');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode(<String, String>{
        'user_email': userEmail,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map?> signUpAsStudent(http.Client client,
      {required String userName,
      required String userEmail,
      required String password}) async {
    var uri = Uri.http('localhost:4000', '/api/v1/users/signupAsStudent');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode(<String, String>{
        'user_name': userName,
        'user_email': userEmail,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      return data;
    } else {
      var error = json.decode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Map?> signUpAsOwner(http.Client client,{
    required schoolName,
    required schoolEmail,
    required String userName,
    required String userEmail,
    required String password,
  }) async {
    var uri = Uri.http('localhost:4000', '/api/v1/users/signupAsOwner');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode(<String, String>{
        'school_name': schoolName,
        'school_email': schoolEmail,
        'user_name': userName,
        'user_email': userEmail,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      return data;
    } else {
      var error = json.decode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Map?> signUpWithCode(http.Client client,{
    required String code,
    required String userName,
    required String userEmail,
    required String password,
  }) async {
    var uri = Uri.http('localhost:4000', '/api/v1/users/signupWithCode');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
      body: jsonEncode(<String, String>{
        'code': code,
        'user_name': userName,
        'user_email': userEmail,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      return data;
    } else {
      var error = json.decode(response.body);
      throw Exception(error["message"]);
    }
  }

  signOut() {}
  signUp() {}

  Future<String?> getInvitationCodeForCoordinator(http.Client client,String schoolId) async {
    var uri = Uri.http(
        'localhost:4000', '/api/v1/schools/$schoolId/inviteCoordinator');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['code'] as String;
    } else {
      var error = json.decode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<String?> getInvitationCodeForTeacher(http.Client client,String schoolId) async {
    var uri =
        Uri.http('localhost:4000', '/api/v1/schools/$schoolId/inviteTeacher');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['code'] as String;
    } else {
      var error = json.decode(response.body);
      throw Exception(error["message"]);
    }
  }
}
