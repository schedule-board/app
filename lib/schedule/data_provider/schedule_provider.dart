import 'dart:convert';
import 'package:http/http.dart' as http;
import '../bloc/bloc.dart';
import '../models/schedule.dart';

class ScheduleProvider {
  ScheduleProvider();
  Future<List<dynamic>> loadSchedule(String schoolId) async {
    var uri = "http://localhost:4000/api/v1/schedules";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)["data"] as List<dynamic>;

        List<ScheduleItem> posts =
            jsonData.map((json) => ScheduleItem.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
