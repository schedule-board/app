import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/class_model.dart';

class ClassApiProvider {
  ClassApiProvider();
  Future<List<Class>> loadClasses(
      http.Client client, String schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes";
    // q: how do I set timeout for this request?

    var response = await client.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    }).timeout(
      const Duration(seconds: 10),
      onTimeout: () => http.Response('Error', 408),
    );

    if (response.statusCode == 200) {
      var coursedata = jsonDecode(response.body)["data"];
      List<Class> classes = coursedata.map<Class>((courseJson) {
        return Class.fromJson(courseJson);
      }).toList();

      return classes;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<List<Class>> loadAllClasses(http.Client client, token) async {
    var uri = "http://localhost:4000/api/v1/classes";
    var response = await client.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    }).timeout(
      const Duration(seconds: 10),
      onTimeout: () => http.Response('Error', 408),
    );

    if (response.statusCode == 200) {
      List coursedata = jsonDecode(response.body)["data"];
      List<Class> classes = coursedata.map<Class>((courseJson) {
        return Class.fromJson(courseJson);
      }).toList();
      return classes;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Class> loadClassOne(
      http.Client client, String classId, String? schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes/$classId";
    var response = await client.get(Uri.parse(uri), headers: <String, String>{
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

  Future<Class> createClass(
      http.Client client, Map classs, String? schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes";
    var response = await client.post(Uri.parse(uri),
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

  Future<Class> updateClass(
      http.Client client, Map classs, classId, schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes/$classId";
    var response = await client.patch(Uri.parse(uri),
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

  Future<dynamic> deleteClass(
      http.Client client, classId, schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/classes/$classId";

    var response =
        await client.delete(Uri.parse(uri), headers: <String, String>{
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
