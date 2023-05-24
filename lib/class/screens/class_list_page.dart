import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import '../models/class_model.dart';
import '../models/class_dummydata.dart';

class ClassListPage extends StatelessWidget {
  const ClassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class List"),
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
                        classes[index].classname,
                      ),
                      subtitle: Text(classes[index].schoolName,
                          style: const TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
            itemCount: classes.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
