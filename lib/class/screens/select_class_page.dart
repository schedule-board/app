import 'package:flutter/material.dart';
import 'package:schedule/class/models/class_dummydata.dart';

class SelectClassPage extends StatelessWidget {
  const SelectClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    List classes = [
      'class1',
      'class2',
      'class3',
      'class4',
      'class5',
      'class6',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Select Class")),
      body: Center(
          child: ListView.builder(
        itemBuilder: (context, index) => Card(
          elevation: 3,
          child: InkWell(
            onTap: () {},
            child: ListTile(
              leading: const Icon(Icons.school),
              title: Text(
                classes[index],
              ),
              trailing: const Icon(Icons.delete),
            ),
          ),
        ),
        itemCount: classes.length,
      )),
    );
  }
}
