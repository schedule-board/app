import '../data_provider/course_provider.dart';
import '../models/course_model.dart';

class CourseRepository {
  final CourseProvider courseProvider;

  CourseRepository(this.courseProvider);

  Future<List<dynamic>> load(client, String schoolId, token) async {
    return courseProvider.loadCourses(client, schoolId, token);
  }

  Future<Course> loadOne(
      client, String schoolId, String? courseId, token) async {
    return courseProvider.loadCourseOne(client, schoolId, courseId, token);
  }

  Future<Course> create(client, Map course, String? schoolId, token) async {
    return courseProvider.createCourse(client, course, schoolId, token);
  }

  Future<Course> update(
      client, Map course, String? courseId, String? schoolId, token) async {
    return courseProvider.updateCourse(
        client, course, courseId, schoolId, token);
  }

  Future<dynamic> delete(
      client, String? courseId, String? schoolId, token) async {
    return courseProvider.deleteCourse(client, courseId, schoolId, token);
  }
}
