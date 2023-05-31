import 'package:schedule/course/models/course_model.dart';
import 'package:schedule/database_helper/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_provider/class_api_provider.dart';
import '../models/class_model.dart';

class ClassRepository {
  final ClassApiProvider classApiProvider = ClassApiProvider();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  ClassRepository();

  Future<List<dynamic>> loadClassesOfSchool(String schoolId, token) async {
    return classApiProvider.loadClasses(schoolId, token);
  }

  Future<List<dynamic>> loadAllClasses(token) async {
    return classApiProvider.loadAllClasses(token);
  }

  Future<Class> loadSingleClass(String schoolId, String? classId, token) async {
    return classApiProvider.loadClassOne(schoolId, classId, token);
  }

  Future<Class> createClass(Map course, String? schoolId, token) async {
    return classApiProvider.createClass(course, schoolId, token);
  }

  Future<Class> updateClass(Map course, String? classId, String? schoolId, token) async {
    return classApiProvider.updateClass(course, classId, schoolId, token);
  }

  Future<dynamic> deleteClass(String? classId, String? schoolId, token) async {
    return classApiProvider.deleteClass(classId, schoolId, token);
  }

  Future<void> syncClassDataWithServer(String schoolId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var classes = await classApiProvider.loadClasses(schoolId, token);
    for (var element in classes) {
      await databaseHelper.upsertClass(element.toJson());
    }
  }

  Future<List<Class>> loadClassesFromLocal(String schoolId) async {
    var result = await DatabaseHelper().getAllClasses();
    var classes = result.map((e) => Class.fromJson(e)).toList();
    return classes;
  }

  Future<List<Course>> loadCoursesFromLocal(String classId) async {
    var result = await DatabaseHelper().getAllCourses();
    var courses = result.map((e) => Course.fromJson(e)).toList();
    return courses;
  }
}
