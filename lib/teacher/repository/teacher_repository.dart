import '../data_provider/teacher_provider.dart';

class TeacherRepository {
  final TeacherProvider teacherProvider;

  TeacherRepository(this.teacherProvider);

  Future<List<dynamic>> load(client, String schoolId) async {
    return teacherProvider.loadTeachers(client, schoolId);
  }
}
