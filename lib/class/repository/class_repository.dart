import 'package:schedule/class/data_provider/class_local_provider.dart';
import 'package:schedule/course/models/course_model.dart';
import 'package:schedule/database_helper/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_provider/class_api_provider.dart';
import '../models/class_model.dart';

class ClassRepository {
  final ClassApiProvider classApiProvider = ClassApiProvider();
  final ClassLocalProvider classLocalProvider = ClassLocalProvider();

  ClassRepository();

  Future<List<dynamic>> loadClassesOfSchool(
      client, String schoolId, token) async {
    // try {
    return classApiProvider.loadClasses(client, schoolId, token);
    // } catch (e) {
    //   // todo: change this
    //   return classApiProvider.loadClasses(schoolId, token);
    // }
  }

  Future<List<dynamic>> loadAllClasses(client, token) async {
    // try {
    return await classApiProvider.loadAllClasses(client, token);
    // } catch (e) {
    //   return await classLocalProvider.getAllClasses();
    // }
  }

  Future<Class> loadSingleClass(
      client, String schoolId, String? classId, token) async {
    return classApiProvider.loadClassOne(client, schoolId, classId, token);
  }

  Future<Class> createClass(client, Map course, String? schoolId, token) async {
    return classApiProvider.createClass(client, course, schoolId, token);
  }

  Future<Class> updateClass(
      client, Map course, String? classId, String? schoolId, token) async {
    return classApiProvider.updateClass(
        client, course, classId, schoolId, token);
  }

  Future<dynamic> deleteClass(
      client, String? classId, String? schoolId, token) async {
    return classApiProvider.deleteClass(client, classId, schoolId, token);
  }

  Future<void> syncClassDataWithServer(client, String schoolId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var classes = await classApiProvider.loadClasses(client, schoolId, token);
    for (var element in classes) {
      await classLocalProvider.upsertClass(element.toJson());
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
