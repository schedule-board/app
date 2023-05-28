import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/class_model.dart';

class ClassProvider {
  ClassProvider();

  Future<List<dynamic>> loadClassesForSelect() async {
    var uri = Uri.http('localhost:4000', '/api/v1/courses');

    final response = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'});

    if (response.statusCode == 200) {
      var classesForSelectData = jsonDecode(response.body)["data"];

      List<dynamic> classesForSelect =
          classesForSelectData.map((classesForSelectJson) {
        return classesForSelectModel.fromJson(classesForSelectJson);
      }).toList();
      return classesForSelect;
    } else {
      throw Exception('Failed to load classes');
    }
  }

  Future<List<dynamic>> loadClassesForManage(String shoolID) async {
    var uri = Uri.http('localhost:4000', '/api/v1/schools/$shoolID/classes');

    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
    );

    if (response.statusCode == 200) {
      var classData = jsonDecode(response.body)["data"];

      List<dynamic> classes = classData.map((classJson) {
        return classesForManage.fromJson(classJson);
      }).toList();
      return classes;
    } else {
      throw Exception('Failed to load classes');
    }
  }

  // localhost:4000/api/v1/schools/646a2b183748bfedb7cb7819/classes
  Future<List<dynamic>> createClassForSchool(String shoolId, data) async {
    var uri = Uri.http('localhost:4000', '/api/v1/schools/$shoolId/classes');

    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    }, body: {
      {
        "class_name": data.class_name,
        "courses": data.courses,
      }
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      var classData = jsonDecode(response.body)["data"];

      List<dynamic> classes = classData.map((classJson) {
        return classesForManage.fromJson(classJson);
      }).toList();
      return classes;
    } else {
      throw Exception('Failed to load classes');
    }
  }
}
