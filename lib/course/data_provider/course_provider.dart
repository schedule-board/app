import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/course_model.dart';
import '../models/schedules_Amodel.dart';

class CourseProvider {
  CourseProvider();

//  Future<Course> createCourse(Course course){
//   var uri = "localhost:4000/schools/${course.schoolId}/courses";
//   var response = http.post( Uri.parse(uri),headers: <String,String>{
//      'Content-Type': 'application/json; charset=UTF-8',
//   },body: jsonEncode(<String,String>{
//     "course_name":course.courseName,
//     "teacher":,
//     "schedule":
//   },));
//  }
// }

  Future<List<dynamic>> loadCourse(String schoolId) async {
    var uri =
        "http://localhost:4000/api/v1/schools/646a2b183748bfedb7cb7819/schedules";
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var coursedata = jsonDecode(response.body)["data"];
      List<dynamic> courses = coursedata.map((courseJson) {
        return Schedule.fromJson(courseJson);
      }).toList();
      return courses;
    } else {
      throw Exception('Failed to load course');
    }
  }
}
