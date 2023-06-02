import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../../lib/class/data_provider/class_api_provider.dart';
import '../../lib/class/models/class_model.dart';
// import '../../lib/class/repository/class_repository.dart';
// import '../../lib/class/bloc/class_bloc.dart';
// import '../../lib/class/bloc/class_event.dart';
// import '../../lib/class/bloc/class_state.dart';

import 'class_test.mocks.dart';
import 'package:mockito/annotations.dart';

import 'dart:convert';

@GenerateMocks([http.Client])
// class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('classRequests', () {
    late MockClient client;
    setUp(() {
      client = MockClient();
    });
    test(
        'returns an list of classes if the load class http call completes successfully',
        () async {
      when(client.get(
          Uri.parse("http://localhost:4000/api/v1/schools/10/classes"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{"data": [{"_id": "006","class_name": "section-123","school": {"_id": "002","school_name": "oneline","id": "003"},"courses": ["004","005"],"id": "006"}]}',
          200));
      var classes = await ClassApiProvider().loadClasses(client, "10", "1");
      expect(classes, isA<List<Class>>());
    });

    test(
        'returns a class if the load one class http call completes successfully',
        () async {
      when(client.get(
          Uri.parse("http://localhost:4000/api/v1/schools/12/classes/10"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{"data": { "_id": "001", "class_name": "section-123", "school": {"_id": "002","school_name": "oneline","id": "003" },"courses": [  {"_id": "001","course_name": "javascript", "school": {"_id": "011","school_name": "oneline","school_email": "oneline@gmail.com","owner": "012", "id": "021" }, "teacher": "0232",  "id": "043"}],"id": "03434"}}',
          200));
      var classs =
          await ClassApiProvider().loadClassOne(client, "10", "12", "1");
      expect(classs, isA<Class>());
    });

    test(
        'returns a classes if the load all classes http call completes successfully',
        () async {
      when(client.get(Uri.parse("http://localhost:4000/api/v1/classes"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{ "data": [ { "_id": "001", "class_name": "section-123", "school": {"_id": "001","school_name": "oneline", "id": "001"},"courses": ["001"], "id": "001"}]}',
          200));
      var classs = await ClassApiProvider().loadAllClasses(client, "1");
      expect(classs, isA<List<Class>>());
    });

    test('returns a class if the create class http call completes successfully',
        () async {
      Map c = {
        "class_name": "sec-1",
        "courses": ["001", "002"]
      };

      when(client.post(
              Uri.parse("http://localhost:4000/api/v1/schools/10/classes"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Authorization": "Bearer 12"
              },
              body: jsonEncode(c)))
          .thenAnswer((_) async => http.Response(
              '{"data": {"class_name": "sds-bbb","school": "3434","courses": [ "3434"], "_id": "3434", "id": "1212" }}',
              201));
      var classs = await ClassApiProvider().createClass(client, c, "10", "12");
      expect(classs, isA<Class>());
    });

    test('returns a class if the update class http call completes successfully',
        () async {
      Map c = {
        "class_name": "sec-1",
        "courses": ["001", "002"]
      };

      when(client.patch(
              Uri.parse("http://localhost:4000/api/v1/schools/10/classes/2"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Authorization": "Bearer 12"
              },
              body: jsonEncode(c)))
          .thenAnswer((_) async => http.Response(
              '{"data": {"class_name": "sec-1","school": "10","courses": ["001", "002"], "_id": "3434", "id": "1212" }}',
              200));
      var classs =
          await ClassApiProvider().updateClass(client, c, "2", "10", "12");
      expect(classs, isA<Class>());
    });

    test(
        'returns a nothing if the delete class http call completes successfully',
        () async {
      when(client.delete(
          Uri.parse("http://localhost:4000/api/v1/schools/10/classes/12"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response("", 204));
      var course =
          await ClassApiProvider().deleteClass(client, "12", "10", "1");
      expect(course, equals(true));
    });
  });
}
