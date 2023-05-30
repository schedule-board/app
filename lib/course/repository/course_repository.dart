import 'package:schedule/database_helper/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_provider/course_provider.dart';
import '../models/course_model.dart';

class CourseRepository {
  final CourseApiProvider courseApiProvider = CourseApiProvider();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  CourseRepository();

  Future<List<dynamic>> load(String schoolId, token) async {
    return courseApiProvider.loadCourses(schoolId, token);
  }

  Future<Course> loadOne(String schoolId, String? courseId, token) async {
    return courseApiProvider.loadCourseOne(schoolId, courseId, token);
  }

  Future<Course> create(Map course, String? schoolId, token) async {
    return courseApiProvider.createCourse(course, schoolId, token);
  }

  Future<Course> update(Map course, String? courseId, String? schoolId, token) async {
    return courseApiProvider.updateCourse(course, courseId, schoolId, token);
  }

  Future<dynamic> delete(String? courseId, String? schoolId, token) async {
    return courseApiProvider.deleteCourse(courseId, schoolId, token);
  }

  Future<void> syncCourseDataWithServer(String schoolId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var courses = await CourseApiProvider().loadCourses(schoolId, token);
    for (var element in courses) {
      await databaseHelper.upsertCourse(element.toJson());
    }
  }
}
