import 'dart:convert';

import 'package:http/http.dart' as http;
import '../bloc/bloc.dart';

class ScheduleProvider {
  ScheduleProvider();
  Future<List<dynamic>> loadSchedule(String schoolId) async {
    // if it is not working try scheduleData[0]
    // List<dynamic> dynamicList = [];
    // for (var item in scheduleData) {
    //   dynamicList.add(Map<String, dynamic>.from(item));
    // }
    var uri = "http://localhost:4000/api/v1/schedules";
    var uri2 = "http://jsonplaceholder.typicode.com/posts";

    try {
var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) as List<dynamic>;

      List<Schedule> posts = jsonData.map((json) => Schedule.fromJson(json)).toList();

      return posts;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
    
    // var response = await http.get(Uri.parse(uri2));
    // if (response.statusCode == 200) {
    //   var scheduleData = jsonDecode(response.body);

    //   print("schedule provider above");

    //   Schedules mySchedule =
    //       Schedules.fromJson(scheduleData as Map<String, dynamic>);
    //   print("hello");
    //   print([mySchedule]);
    //   return [mySchedule];

    //   // return myClasses;
    // } else {
    //   throw Exception('Failed to load course');
    // }
  }
}

class Schedules {
  int? userId;
  int? id;
  String? title;
  String? body;

  Schedules({this.userId, this.id, this.title, this.body});

  Schedules.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}


class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
