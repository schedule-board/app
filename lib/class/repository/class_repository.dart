import '../data_provider/class_provider.dart';
import '../models/class_model.dart';

class ClassRepository {
  final ClassProvider classProvider;

  ClassRepository(this.classProvider);

  Future<List<dynamic>> loadClassesForSelect() async {
    return classProvider.loadClassesForSelect();
  }

  Future<List<dynamic>> loadClassesForManage(String schoolId) async {
    return classProvider.loadClassesForManage(schoolId);
  }

  Future<List<dynamic>> createClass(String shoolId,classesForManage data) async {
    return classProvider.createClassForSchool(shoolId,data);
  }
}
