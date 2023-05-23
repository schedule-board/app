import 'package:flutter/material.dart';

class ClassDetailPage extends StatefulWidget {
  const ClassDetailPage({super.key});

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String? _className;
  List<String> _assignedCourses = [];

  List<String> _availableCourses = [
    'Course 1',
    'Course 2',
    'Course 3',
    'Course 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class detail'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Class Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a class name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _className = value!;
                },
              ),
              SizedBox(height: 10),
              Text(
                'Courses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _assignedCourses.length,
                itemBuilder: (context, index) {
                  final course = _assignedCourses[index];
                  return ListTile(
                    title: Text(course),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _assignedCourses.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showAddCourseDialog();
                },
                child: Text('Add Course'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Perform submit action here
                        print('Class Name: $_className');
                        print('Assigned Courses: $_assignedCourses');
                      }
                    },
                    child: Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCourseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Course'),
          content: Container(
            width: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _availableCourses.length,
              itemBuilder: (context, index) {
                final course = _availableCourses[index];
                return ListTile(
                  title: Text(course),
                  onTap: () {
                    setState(() {
                      _assignedCourses.add(course);
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class Schedule {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  Schedule({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });
}
