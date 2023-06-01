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

  Future<List<Map<String, dynamic>>> getAllClasses() async {
    return await db.query('class');
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
