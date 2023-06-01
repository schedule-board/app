import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/course_model.dart';

class CourseProvider {
  CourseProvider();
  Future<List<Course>> loadCourses(
      http.Client client, String schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/courses";
    var response = await client.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 200) {
      List coursedata = jsonDecode(response.body)["data"];
      List<Course> courses = coursedata.map((courseJson) {
        return Course.fromJson(courseJson);
      }).toList();
      return courses;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Course> loadCourseOne(
      http.Client client, String schoolId, String? courseId, token) async {
    var uri =
        "http://localhost:4000/api/v1/schools/$schoolId/courses/$courseId";
    var response = await client.get(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 200) {
      var coursedata = jsonDecode(response.body)["course"];
      Course course = Course.fromJson(coursedata);
      return course;
    } else {
      throw Exception([
        'Failed to load course',
      ]);
    }
  }

  Future<Course> createCourse(
      http.Client client, Map course, String? schoolId, token) async {
    var uri = "http://localhost:4000/api/v1/schools/$schoolId/courses";
    var response = await client.post(Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(course));

    if (response.statusCode == 201) {
      var coursedata = jsonDecode(response.body)["course"];
      var course = Course.fromJson(coursedata);

      return course;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Course> updateCourse(
      http.Client client, Map course, courseId, schoolId, token) async {
    var uri =
        "http://localhost:4000/api/v1/schools/$schoolId/courses/$courseId";
    var response = await client.patch(Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(course));

    if (response.statusCode == 200) {
      var coursedata = jsonDecode(response.body)["updatedCourse"];
      var course = Course.fromJson(coursedata);
      return course;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<dynamic> deleteCourse(
      http.Client client, courseId, schoolId, token) async {
    var uri =
        "http://localhost:4000/api/v1/schools/$schoolId/courses/$courseId";

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
