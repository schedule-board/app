import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/schedules_Amodel.dart';
// import '../../auth/bloc/auth_bloc.dart';

class ScheduleProvider {
  ScheduleProvider();
  Future<List<Schedule>> loadSchedules(http.Client client, filter) async {
    var uri;
    if (filter.containsKey("school")) {
      uri = "http://localhost:4000/api/v1/schedules?school=${filter['school']}";
    }

    if (filter.containsKey("teacher")) {
      uri =
          "http://localhost:4000/api/v1/schedules?teacher=${filter['teacher']}";
    }

    if (filter.containsKey("courses")) {
      var classFilter = (filter["courses"] as List)
          .map((course) => "course=$course")
          .toList()
          .join("&");
      uri = "http://localhost:4000/api/v1/schedules?$classFilter";
    }
    var response = await client.get(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${filter["token"]}"
      },
    );

    if (response.statusCode == 200) {
      List scheduledata = jsonDecode(response.body)["data"];

      List<Schedule> schedules = scheduledata.map((json) {
        return Schedule.fromJson(json);
      }).toList();

      return schedules;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<Schedule> updateSchedule(
      http.Client client, Map schedule, scheduleId, token) async {
    var uri = "http://localhost:4000/api/v1/schedules/$scheduleId";
    var response = await client.patch(Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(schedule));

    if (response.statusCode == 200) {
      var scheduleData = jsonDecode(response.body)["data"];
      var schedule = Schedule.fromJson(scheduleData);
      return schedule;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }

  Future<dynamic> deleteSchedule(http.Client client, scheduleId, token) async {
    var uri = "http://localhost:4000/api/v1/schedules/$scheduleId";

    var response =
        await client.delete(Uri.parse(uri), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 204) {
      return true;
    } else {
      var error = jsonDecode(response.body);
      throw Exception(error["message"]);
    }
  }
}
