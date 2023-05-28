import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/teacher_model.dart';

class TeacherProvider {
  TeacherProvider();

  Future<List<dynamic>> loadTeachers(String schoolId) async {
    var uri =
        "http://localhost:4000/api/v1/users?role=teacher&school=$schoolId";
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var teacherdata = jsonDecode(response.body)["data"];

      List<dynamic> teachers = teacherdata.map((teacherJson) {
        return Teacher.fromJson(teacherJson);
      }).toList();
      return teachers;
    } else {
      throw Exception('Failed to load Teacher');
    }
  }
}
