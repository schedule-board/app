import '../data_provider/course_provider.dart';
import '../models/course_model.dart';

class CourseRepository {
  final CourseProvider courseProvider;

  CourseRepository(this.courseProvider);

  Future<List<dynamic>> load(String schoolId) async {
    return courseProvider.loadCourses(schoolId);
  }

  Future<Course> loadOne(String schoolId, String? courseId) async {
    return courseProvider.loadCourseOne(schoolId, courseId);
  }

  Future<Course> create(Map course, String? schoolId) async {
    return courseProvider.createCourse(course, schoolId);
  }

  Future<Course> update(Map course, String? courseId, String? schoolId) async {
    return courseProvider.updateCourse(course, courseId, schoolId);
  }

  Future<dynamic> delete(String? courseId, String? schoolId) async {
    return courseProvider.deleteCourse(courseId, schoolId);
  }
}
