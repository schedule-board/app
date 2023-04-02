import 'package:flutter/material.dart';
import 'package:schedule/subject_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const SubjectDetailPage(), // this will be changed. we're doing this temporarily tot test the SubjectDetailPage
    );
  }
}
