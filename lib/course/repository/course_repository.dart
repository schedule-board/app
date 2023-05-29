import '../data_provider/course_provider.dart';
import '../models/course_model.dart';

class CourseRepository {
  final CourseProvider courseProvider;

  CourseRepository(this.courseProvider);

  Future<List<dynamic>> load(String schoolId, token) async {
    return courseProvider.loadCourses(schoolId, token);
  }

  Future<Course> loadOne(String schoolId, String? courseId, token) async {
    return courseProvider.loadCourseOne(schoolId, courseId, token);
  }

  Future<Course> create(Map course, String? schoolId, token) async {
    return courseProvider.createCourse(course, schoolId, token);
  }

  Future<Course> update(
      Map course, String? courseId, String? schoolId, token) async {
    return courseProvider.updateCourse(course, courseId, schoolId, token);
  }

  Future<dynamic> delete(String? courseId, String? schoolId, token) async {
    return courseProvider.deleteCourse(courseId, schoolId, token);
  }
}
