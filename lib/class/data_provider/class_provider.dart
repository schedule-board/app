import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/class_model.dart';

class ClassProvider {
  ClassProvider();

  Future<List<dynamic>> loadClass(String schoolId) async {
    
    var uri = Uri.http('localhost:4000', '/api/v1/classes');

    final response = await http.get(uri,
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'});
  
    if (response.statusCode == 200) {
      var classData = jsonDecode(response.body)["data"];
      List<dynamic> classes = classData.map((courseJson) {
        return classData.fromJson(courseJson);
      }).toList();
      return classes;
    } else {
      throw Exception('Failed to load classes');
    }
  }
}
