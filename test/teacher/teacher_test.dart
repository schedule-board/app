import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import './teacher_test.mocks.dart';
import 'package:mockito/annotations.dart';
import '../../lib/teacher/models/teacher_model.dart';
import '../../lib/teacher/data_provider/teacher_provider.dart';

import 'dart:convert';

@GenerateMocks([http.Client])
// class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('teachersRequests', () {
    late MockClient client;
    setUp(() {
      client = MockClient();
    });
    test(
        'returns an list of teachers if the load teachers http call completes successfully',
        () async {
      when(client.get(Uri.parse(
              "http://localhost:4000/api/v1/users?role=teacher&school=23")))
          .thenAnswer((_) async => http.Response(
              '{"data": [{"_id": "909","user_name": "boogboog","role": "teacher"}]}',
              200));
      var teachers = await TeacherProvider().loadTeachers(client, "23");
      expect(teachers, isA<List<Teacher>>());
    });
  });
}
