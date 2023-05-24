import '../data_provider/class_provider.dart';
import '../models/class_model.dart';


class ClassRepository {
  final ClassProvider classProvider;

  ClassRepository(this.classProvider);

  Future<List<dynamic>> load(String schoolId) async {
    return classProvider.loadClass(schoolId);
  }
} 