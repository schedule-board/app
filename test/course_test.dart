import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../lib/course/bloc/bloc.dart';
import '../lib/course/models/course_model.dart';
import '../lib/course/data_provider/course_provider.dart';
import 'package:mockito/annotations.dart';
import './course_test.mocks.dart';
import 'dart:convert';

@GenerateMocks([http.Client])
// class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('CourseModel', () {
    late MockClient client;
    setUp(() {
      client = MockClient();
    });

    test(
        'returns an list of Course if the load course http call completes successfully',
        () async {
      when(client.get(
          Uri.parse("http://localhost:4000/api/v1/schools/10/courses"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{"data": [{ "_id": "002", "course_name": "a","school": { "_id": "1",  "school_name": "b", "school_email": "b@gmail.com",  "owner": "002", "id": "003" },"teacher": "004", "id": "002"  }]}',
          200));
      var courses = await CourseProvider().loadCourses(client, "10", "1");
      expect(courses, isA<List<Course>>());
    });

    test(
        'returns a Course if the load one course http call completes successfully',
        () async {
      when(client.get(
          Uri.parse("http://localhost:4000/api/v1/schools/10/courses/12"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{"course": {"course_name": "javascript","school": { "school_name": "oneline","id":"002"}, "teacher": { "_id": "001", "user_name": "meme"}, "schedules": [{"dayOfTheWeek": "monday","startTime": "1:34 PM","endTime": "2:34 PM", "id": "001"}],"id": "002"}}',
          200));
      var course =
          await CourseProvider().loadCourseOne(client, "10", "12", "1");
      expect(course, isA<Course>());
    });

    test(
        'returns a Course if the create course http call completes successfully',
        () async {
      Map c = {
        "course_name": "javascript",
        "teacher": "001",
        "schedules": {
          "dayOfTheWeek": "monday",
          "startTime": "1:34 PM",
          "endTime": "2:34 PM"
        }
      };

      when(client.post(
              Uri.parse("http://localhost:4000/api/v1/schools/10/courses"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Authorization": "Bearer 12"
              },
              body: jsonEncode(c)))
          .thenAnswer((_) async => http.Response(
              '{"course": {"course_name": "javascript","school": { "school_name": "oneline","id":"002"}, "teacher": { "_id": "001", "user_name": "meme"}, "schedules": [{"dayOfTheWeek": "monday","startTime": "1:34 PM","endTime": "2:34 PM", "id": "001"}],"id": "002"}}',
              201));

      var course = await CourseProvider().(client, c, "10", "12");
      expect(course, isA<Course>());
    });

    test(
        'returns a Course if the update course http call completes successfully',
        () async {
      Map c = {
        "course_name": "javascript",
        "teacher": "001",
        "schedules": {
          "dayOfTheWeek": "monday",
          "startTime": "1:34 PM",
          "endTime": "2:34 PM"
        }
      };

      when(client.patch(
              Uri.parse("http://localhost:4000/api/v1/schools/10/courses/10"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Authorization": "Bearer 12"
              },
              body: jsonEncode(c)))
          .thenAnswer((_) async => http.Response(
              '{"course": {"course_name": "javascript","school": { "school_name": "oneline","id":"002"}, "teacher": { "_id": "001", "user_name": "meme"}, "schedules": [{"dayOfTheWeek": "monday","startTime": "1:34 PM","endTime": "2:34 PM", "id": "001"}],"id": "002"}}',
              200));

      var course =
          await CourseProvider().updateCourse(client, c, "10", "10", "12");
      expect(course, isA<Course>());
    });

    test(
        'returns a nothing if the delete course http call completes successfully',
        () async {
      when(client.delete(
          Uri.parse("http://localhost:4000/api/v1/schools/10/courses/12"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response("", 204));
      var course = await CourseProvider().deleteCourse(client, "12", "10", "1");
      expect(course, equals(true));
    });
  });
}
