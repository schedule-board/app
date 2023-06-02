import 'package:schedule/class/models/class_model.dart';
import 'package:schedule/database_helper/db_helper.dart';
import 'package:schedule/schedule/models/schedules_Amodel.dart';
import 'package:sqflite/sqlite_api.dart';

class ScheduleLocalProvider {
  late Database db;

  ScheduleLocalProvider() {
    DatabaseHelper().db.then((value) => db = value);
  }

  Future<void> upsertSchedule(Map<String, dynamic> scheduleData) async {
    try{
      await db.insert('schedule', scheduleData,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch(e){
      print(e);
    }
  }

  Future<List<Schedule>> getAllSchedules() async {
    var result = await db.query('schedule');
    var scheduleList = result.toList().map<Schedule>((e) {
      return Schedule.fromJson(Map<String, dynamic>.from(e));
    }).toList();
    return scheduleList;
  }

  // Future<Map<String, dynamic>?> getClassById(String classId) async {
  //   var result =
  //       await db.query('class', where: 'classId = ?', whereArgs: [classId]);
  //   if (result.isEmpty) {
  //     return null;
  //   }
  //   return result.first;
  // }

  // Future<bool> deleteClassById(String classId) async {
  //   var result =
  //       await db.delete('class', where: 'classId = ?', whereArgs: [classId]);
  //   return result > 0;
  // }
}
