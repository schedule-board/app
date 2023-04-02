import 'package:flutter/material.dart';

class Schedule {
  late ComparableTime start;
  late ComparableTime end;
  late String courseName;

  Schedule({
    required ComparableTime start,
    required ComparableTime end,
    required String courseName,
  }) {
    // we complain if the start is higher than the end
    if (start.inMinutes() >= end.inMinutes()) {
      throw Exception("start must be lower than end for a schedule");
    }
    this.start = start;
    this.end = end;
    this.courseName = courseName;
  }

  int lengthInMinutes() {
    return end.inMinutes() - start.inMinutes();
  }

  double lengthInHours() {
    return end.inHours() - start.inHours();
  }
}

class ComparableTime extends TimeOfDay {
  const ComparableTime({
    required int hour,
    required int minute,
  }) : super(hour: hour, minute: minute);

  factory ComparableTime.now() {
    var temp = TimeOfDay.now();
    return ComparableTime(hour: temp.hour, minute: temp.minute);
  }

  factory ComparableTime.fromDateTime(DateTime dateTime) {
    var temp = TimeOfDay.fromDateTime(dateTime);
    return ComparableTime(hour: temp.hour, minute: temp.minute);
  }

  bool isLessThan(TimeOfDay other) {
    return hour * 60 + minute < other.hour * 60 + other.minute;
  }

  bool isGreaterThan(TimeOfDay other) {
    return hour * 60 + minute > other.hour * 60 + other.minute;
  }

  bool isEqualTo(TimeOfDay other) {
    return hour * 60 + minute == other.hour * 60 + other.minute;
  }

  int inMinutes() {
    /// returns the number of minutes from 00:00 to to this time of day.
    return hour * 60 + minute;
  }

  double inHours() {
    /// returns the number of hours (floating) from 00:00 to this time of day.
    return hour + minute / 60;
  }
}
