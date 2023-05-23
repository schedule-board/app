import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import '../models/course_model.dart';
import '../models/course_dummydaty.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("course List"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
            itemBuilder: (context, index) => Card(
                  elevation: 3,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(
                        courses[index].courseName,
                      ),
                      subtitle: Text(courses[index].schoolName,
                          style: const TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
            itemCount: courses.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
