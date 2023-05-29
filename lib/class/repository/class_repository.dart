import 'package:schedule/course/models/course_model.dart';
import 'package:schedule/database_helper/db_helper.dart';

import '../data_provider/class_api_provider.dart';
import '../models/class_model.dart';

class ClassRepository {
  final ClassApiProvider classProvider;

  ClassRepository(this.classProvider);

  Future<List<dynamic>> loadClassesOfSchoolFromApi(String schoolId, token) async {
    return classProvider.loadClasses(schoolId, token);
  }

  Future<List<dynamic>> loadAllClassesFromApi(token) async {
    return classProvider.loadAllClasses(token);
  }

  Future<Class> loadSingleClassFromApi(String schoolId, String? classId, token) async {
    return classProvider.loadClassOne(schoolId, classId, token);
  }

  Future<Class> createClassOnApi(Map course, String? schoolId, token) async {
    return classProvider.createClass(course, schoolId, token);
  }

  Future<Class> updateClassOnApi(Map course, String? classId, String? schoolId, token) async {
    return classProvider.updateClass(course, classId, schoolId, token);
  }

  Future<dynamic> deleteClassFromApi(String? classId, String? schoolId, token) async {
    return classProvider.deleteClass(classId, schoolId, token);
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
