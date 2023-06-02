import 'package:sqflite/sqflite.dart';

// IMPORTANT NOTE: all the methods of this class operate in the context of a single school.
// for example, the getAllCourses() method will return all the courses for the current school
// that we can get in the AuthState.

class DatabaseHelper {
  // let's do a singleton here
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return instance;
  }

  var db = openDatabase(
    'schedule_board.db',
    version: 2,
    onCreate: createTables,
  );

  static void createTables(db, version) {
    db.execute('''
        CREATE TABLE class(
          classId TEXT PRIMARY KEY,
          className TEXT,
          schoolName TEXT,
          isSelected INTEGER
        )
      ''');

    db.execute('''
        CREATE TABLE schedule(
          scheduleId TEXT PRIMARY KEY,
          courseName TEXT,
          startTime TEXT,
          endTime TEXT,
          dayOfTheWeek TEXT
          schoolId TEXT,
          teacherName TEXT,
          teacherId TEXT
        )
      ''');
      
    db.execute('''
        CREATE TABLE course(
          courseId TEXT PRIMARY KEY,
          courseName TEXT,
          classId TEXT,
          teacherName TEXT,
          teacherId TEXT,
          schoolName TEXT
        )
      ''');

  }

  Future<void> upsertClass(Map<String, dynamic> classData) async {
    await db.then((database) async {
      await database.insert('class', classData,
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<void> upsertCourse(Map<String, dynamic> courseData) async {
    await db.then((database) async {
      await database.insert('course', courseData,
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<List<Map<String, dynamic>>> getAllClasses() async {
    return await db.then((database) async {
      return await database.query('class');
    });
  }

  Future<List<Map<String, dynamic>>> getAllCourses() async {
    return await db.then((database) async {
      return await database.query('course');
    });
  }

  Future<Map<String, dynamic>?> getClassById(String classId) async {
    return await db.then((database) async {
      var result = await database
          .query('class', where: 'classId = ?', whereArgs: [classId]);
      if (result.isEmpty) {
        return null;
      }
      return result.first;
    });
  }

  Future<Map<String, dynamic>?> getCourseById(String courseId) async {
    return await db.then((database) async {
      var result = await database
          .query('course', where: 'courseId = ?', whereArgs: [courseId]);
      if (result.isEmpty) {
        return null;
      }
      return result.first;
    });
  }

  Future<bool> deleteClassById(String classId) async {
    return await db.then((database) async {
      var result = await database
          .delete('class', where: 'classId = ?', whereArgs: [classId]);
      return result > 0;
    });
  }

  Future<bool> deleteCourseById(String courseId) async {
    return await db.then((database) async {
      var result = await database
          .delete('course', where: 'courseId = ?', whereArgs: [courseId]);
      return result > 0;
    });
  }
}
