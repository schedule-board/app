import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import '../models/class_model.dart';


class ClassListPage extends StatelessWidget {
   ClassListPage({super.key});

  List classes = [];

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
                    child: const ListTile(
                      leading:  Icon(Icons.school),
                      title:  Text(
                        "hi"
            
                      ),
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
