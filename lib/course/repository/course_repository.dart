import '../data_provider/course_provider.dart';
import '../models/course_model.dart';

class CourseRepository {
  final CourseProvider courseProvider;

  CourseRepository(this.courseProvider);

  Future<List<dynamic>> load(String schoolId) async {
    return courseProvider.loadCourse(schoolId);
  }
}
