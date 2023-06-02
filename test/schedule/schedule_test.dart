import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../../lib/class/data_provider/class_api_provider.dart';
import '../../lib/class/models/class_model.dart';
import '../../lib/schedule/bloc/schedule_bloc.dart';
import '../../lib/schedule/data_provider/schedule_provider.dart';
import '../../lib/schedule/models/schedules_Amodel.dart';
import '../../lib/schedule/repository/schedule_repository.dart';
import 'package:mockito/annotations.dart';
import './schedule_test.mocks.dart';

@GenerateMocks([http.Client])
// class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('schedulesRequests', () {
    late MockClient client;

    setUp(() {
      client = MockClient();
    });

    test(
        'returns an list of sechdules if the load sechdules by selecting class http call completes successfully',
        () async {
      when(client.get(
          Uri.parse(
              "http://localhost:4000/api/v1/schedules?course=121&course=122"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{"data": [{"_id": "23","course": {"_id": "12","course_name": "math","school": {"_id": "12","school_name": "oneline","id": "12" }, "id": "12"  }, "school": {"_id": "21", "school_name": "oneline",  "id": "1212"  },"teacher": {  "_id": "23",  "user_name": "meme"},  "dayOfTheWeek": "tuesday",  "startTime": "2:35 PM",  "endTime": "11:31 PM",  "id": "121"  }]}',
          200));
      var schedule = await ScheduleProvider().loadSchedules(client, {
        "courses": ["121", "122"],
        "token": "1"
      });
      expect(schedule, isA<List<Schedule>>());
    });

    test(
        'returns an list of sechdules if the load sechdules http call completes successfully',
        () async {
      when(client.get(
          Uri.parse("http://localhost:4000/api/v1/schedules?teacher=121"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{"data": [{"_id": "23","course": {"_id": "12","course_name": "math","school": {"_id": "12","school_name": "oneline","id": "12" }, "id": "12"  }, "school": {"_id": "21", "school_name": "oneline",  "id": "1212"  },"teacher": {  "_id": "23",  "user_name": "meme"},  "dayOfTheWeek": "tuesday",  "startTime": "2:35 PM",  "endTime": "11:31 PM",  "id": "121"  }]}',
          200));
      var schedule = await ScheduleProvider()
          .loadSchedules(client, {"teacher": "121", "token": "1"});
      expect(schedule, isA<List<Schedule>>());
    });

    test(
        'returns an list of sechdules if the load sechdules http call completes successfully',
        () async {
      when(client.get(
          Uri.parse("http://localhost:4000/api/v1/schedules?school=121"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response(
          '{"data": [{"_id": "23","course": {"_id": "12","course_name": "math","school": {"_id": "12","school_name": "oneline","id": "12" }, "id": "12"  }, "school": {"_id": "21", "school_name": "oneline",  "id": "1212"  },"teacher": {  "_id": "23",  "user_name": "meme"},  "dayOfTheWeek": "tuesday",  "startTime": "2:35 PM",  "endTime": "11:31 PM",  "id": "121"  }]}',
          200));
      var schedule = await ScheduleProvider()
          .loadSchedules(client, {"school": "121", "token": "1"});
      expect(schedule, isA<List<Schedule>>());
    });

    test(
        'returns a schedule if the update schedule http call completes successfully',
        () async {
      Map c = {
        "dayOfTheWeek": "monday",
        "startTime": "1:34 PM",
        "endTime": "2:34 PM"
      };

      when(client.patch(Uri.parse("http://localhost:4000/api/v1/schedules/10"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                "Authorization": "Bearer 12"
              },
              body: jsonEncode(c)))
          .thenAnswer((_) async => http.Response(
              '{ "status": "success", "data": { "_id": "121", "course": {  "_id": "1212","course_name": "math", "school": { "_id": "1212",  "school_name": "oneline",  "school_email": "oneline@gmail.com",  "id": "121"  }, "id": "232"  },  "school": {  "_id": "1232",  "school_name": "oneline",  "id": "1212"  }, "teacher": {    "_id": "2323",    "user_name": "meme"  },  "dayOfTheWeek": "monday",  "startTime": "3:04 PM",  "endTime": "12:04 PM",  "id": "121" }}',
              200));

      var schedule =
          await ScheduleProvider().updateSchedule(client, c, "10", "12");
      expect(schedule, isA<Schedule>());
    });

    test(
        'returns a nothing if the delete schedule http call completes successfully',
        () async {
      when(client.delete(Uri.parse("http://localhost:4000/api/v1/schedules/12"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer 1"
          })).thenAnswer((_) async => http.Response("", 204));
      var course = await ScheduleProvider().deleteSchedule(client, "12", "1");
      expect(course, equals(true));
    });
  });
}
