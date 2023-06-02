import 'package:schedule/class/models/class_model.dart';
import 'package:schedule/database_helper/db_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class ClassLocalProvider {
  late Database db;

  ClassLocalProvider() {
    DatabaseHelper().db.then((value) => db = value);
  }

  Future<void> upsertClass(Map<String, dynamic> classData) async {
    await db.insert('class', classData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Class>> getAllClasses() async {
    var result = await db.query('class');
    var classList = result.toList().map<Class>((e) {
      return Class.fromJson(Map<String, dynamic>.from(e));
    }).toList();
    return classList;
  }

  Future<Map<String, dynamic>?> getClassById(String classId) async {
    var result =
        await db.query('class', where: 'classId = ?', whereArgs: [classId]);
    if (result.isEmpty) {
      return null;
    }
    return result.first;
  }

  Future<bool> deleteClassById(String classId) async {
    var result =
        await db.delete('class', where: 'classId = ?', whereArgs: [classId]);
    return result > 0;
  }
}
