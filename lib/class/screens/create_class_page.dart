import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../course/bloc/bloc.dart';
import '../../auth/bloc/auth_bloc.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({super.key});

  @override
  State<CreateClassPage> createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final _formKey = GlobalKey<FormState>();
  String? _className;
  List _assignedCourses = [];

  List _availableCourses = [];

  @override
  Widget build(BuildContext context) {
    _availableCourses = context.watch<CourseBloc>().state.props;
    var currentSchool = context.watch<AuthBloc>().state.school;
    var token = context.watch<AuthBloc>().state.token;
    if (_availableCourses.length != 0) {
      _availableCourses = _availableCourses[0];
    }

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ClassBloc>(context)
            .add(LoadClassesEvent(currentSchool!.id, token!));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create class'),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
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
                const SizedBox(height: 10),
                const Text(
                  'Courses',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _assignedCourses.length,
                  itemBuilder: (context, index) {
                    final course = _assignedCourses[index];
                    return ListTile(
                      title: Text(course is Map
                          ? course["course_name"]
                          : course.courseName),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _assignedCourses.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showAddCourseDialog();
                  },
                  child: const Text('Add Course'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map classs = {
                        "class_name": _className,
                        "courses": _assignedCourses
                            .map((course) =>
                                course is Map ? course["_id"] : course.courseId)
                            .toList()
                      };
                      BlocProvider.of<ClassBloc>(context).add(
                          CreateClassEvent(classs, currentSchool!.id, token!));
                      _showCreateClassPopup(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
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
                  title: Text(course.courseName),
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

void _showCreateClassPopup(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create Class dialog'),
        content: BlocBuilder<ClassBloc, ClassState>(builder: (context, state) {
          if (state is OneClassOperationSuccess) {
            return Text("${state.classs.className} is sucessfully created");
          }
          if (state is ClassOperationFailure) {
            var errString;
            if (state.error.toString().split(":").length == 2) {
              errString = state.error.toString().split(":")[1];
            } else {
              errString = state.error.toString().split(":");
            }
            return Text("Error ocurr on Creation:\n $errString");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
