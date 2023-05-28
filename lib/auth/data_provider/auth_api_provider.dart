import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiProvider {
  Future<Map?> signIn(String userEmail, String password) async {
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

  signOut() {}
  signUp() {}

  Future<String?> getInvitationCodeForTeacher(String schoolId) async {
    var uri = Uri.http('localhost:4000', '/api/v1/schools/$schoolId/inviteTeacher');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json', 'Accept': '*/*', 'Authorization': 'Bearer ${token}'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['code'] as String;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
