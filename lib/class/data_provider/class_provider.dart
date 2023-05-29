import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/class_model.dart';
// import '../models/.dart';
import '../../auth/bloc/auth_bloc.dart';

class ClassProvider {
  ClassProvider();
  Future<List<dynamic>> loadClasses(String schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes";
    var response = await http.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      var coursedata = jsonDecode(response.body)["data"];
      List<dynamic> classes = coursedata.map((courseJson) {
        return Class.fromJson(courseJson);
      }).toList();

      return classes;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<List<dynamic>> loadAllClasses(token) async {
    var uri = "http://localhost:4000/api/v1/classes";
    var response = await http.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      var coursedata = jsonDecode(response.body)["data"];
      List<dynamic> classes = coursedata.map((courseJson) {
        return Class.fromJson(courseJson);
      }).toList();

      return classes;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Class> loadClassOne(String classId, String? schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes/$classId";
    var response = await http.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 200) {
      var classdata = jsonDecode(response.body)["data"];
      Class classs = Class.fromJson(classdata);
      return classs;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Class> createClass(Map classs, String? schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes";
    var response = await http.post(Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(classs));

    if (response.statusCode == 201) {
      var classdata = jsonDecode(response.body)["data"];
      var classs = Class.fromJson(classdata);

      return classs;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Class> updateClass(Map classs, classId, schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes/$classId";
    var response = await http.patch(Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(classs));

    if (response.statusCode == 200) {
      var classData = jsonDecode(response.body)["data"];
      var classs = Class.fromJson(classData);
      return classs;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<dynamic> deleteClass(classId, schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes/$classId";

    var response = await http.delete(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 204) {
      return true;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }
}
