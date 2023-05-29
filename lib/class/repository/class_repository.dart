import '../data_provider/class_api_provider.dart';
import '../models/class_model.dart';

class ClassRepository {
  final ClassApiProvider classProvider;

  ClassRepository(this.classProvider);

  Future<List<dynamic>> load(String schoolId, token) async {
    return classProvider.loadClasses(schoolId, token);
  }

  Future<List<dynamic>> loadAll(token) async {
    return classProvider.loadAllClasses(token);
  }

  Future<Class> loadOne(String schoolId, String? classId, token) async {
    return classProvider.loadClassOne(schoolId, classId, token);
  }

  Future<Class> create(Map course, String? schoolId, token) async {
    return classProvider.createClass(course, schoolId, token);
  }

  Future<Class> update(Map course, String? classId, String? schoolId, token) async {
    return classProvider.updateClass(course, classId, schoolId, token);
  }

  Future<dynamic> delete(String? classId, String? schoolId, token) async {
    return classProvider.deleteClass(classId, schoolId, token);
  }
}
