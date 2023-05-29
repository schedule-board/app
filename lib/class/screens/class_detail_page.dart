import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../course/bloc/bloc.dart';
import '../../auth/bloc/auth_bloc.dart';

class ClassDetailPage extends StatefulWidget {
  const ClassDetailPage({super.key});

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
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
          title: const Text('Class detail'),
        ),
        body: BlocBuilder<ClassBloc, ClassState>(builder: (context, state) {
          if (state is OneClassOperationSuccess) {
            _className = state.classs.className;
            _assignedCourses = state.classs.courses!;

            return Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      initialValue: _className,
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _showAddCourseDialog(_availableCourses);
                      },
                      child: Text('Add Course'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Map classs = {
                                "class_name": _className,
                                "courses": _assignedCourses
                                    .map((course) => course is Map
                                        ? course["_id"]
                                        : course.courseId)
                                    .toList()
                              };
                              BlocProvider.of<ClassUpdateBloc>(context).add(
                                  UpdateClassEvent(classs, state.classs.classId,
                                      currentSchool!.id, token!));

                              _showUpdateClassPopup(context);
                            }
                          },
                          child: Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ClassBloc>(context).add(
                                DeleteClassEvent(state.classs.classId,
                                    currentSchool!.id, token!));
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is ClassOperationFailure) {
            return Center(child: Text(state.error.toString()));
          } else if (state is DeleteClassOperationSuccess) {
            return Center(child: Text("class successfully Deleted"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  void _showAddCourseDialog(_availableCourses) {
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

void _showUpdateClassPopup(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Class dialog'),
        content: BlocBuilder<ClassUpdateBloc, ClassUpdateState>(
            builder: (context, state) {
          if (state is ClassUpdateOperationSuccess) {
            return Text("${state.classs.className} is sucessfully updated");
          }
          if (state is ClassUpdateOperationFailure) {
            return Text("Error ocurr on update:\n ${state.error.toString()}");
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
