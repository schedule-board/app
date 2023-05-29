import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "../../course/bloc/bloc.dart";
import "../../course/models/course_model.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/teacher/bloc/bloc.dart';
import '../../auth/bloc/auth_bloc.dart';

class CourseDetailPage extends StatefulWidget {
  String? id;

  CourseDetailPage({super.key, this.id});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();

  final TextEditingController _creditHourController = TextEditingController();

  final TextEditingController _ectsController = TextEditingController();

  String? _courseName;

  String? _selectedTeacher;

  late TimeOfDay _selectedStartTime = TimeOfDay.now();
  late TimeOfDay _selectedEndTime = TimeOfDay.now();

  List _teachers = [];

  List<Schedule> _schedules = [];
  var firstLoad = true;
  @override
  Widget build(BuildContext context) {
    List teachers = context.watch<TeacherBloc>().state.props;
    var currentSchool = context.watch<AuthBloc>().state.school;
    var token = context.watch<AuthBloc>().state.token;

    if (teachers.length != 0) {
      _teachers = teachers[0];
    }

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<CourseBloc>(context)
            .add(LoadCourseEvent(currentSchool?.id,token));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Course detail'),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child:
                BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
              if (state is CourseLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is OneCourseOperationSuccess) {
                _courseName = state.course.courseName;
                _selectedTeacher = state.course.teacherName;

                if (firstLoad) {
                  firstLoad = false;
                  _schedules = state.course.schedules!
                      .map((schedule) => Schedule(
                          dayOfWeek: schedule.day,
                          startTime: schedule.startTime,
                          endTime: schedule.endTime))
                      .toList();
                }

                return Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Course Name',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter a course name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _courseName = value;
                      },
                      initialValue: state.course.courseName,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Teacher',
                      ),
                      value: state.course.teacherId,
                      items: _teachers.map((teacher) {
                        return DropdownMenuItem(
                          value: teacher.teacherId,
                          child: Text(teacher.teacherName),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a teacher';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedTeacher = value as String;
                        });
                      },
                      onSaved: (value) {
                        _selectedTeacher = value as String;
                      },
                    ),
                    Text(
                      'Schedules',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _schedules.length,
                      itemBuilder: (context, index) {
                        // final schedule = _schedules[index];
                        return ListTile(
                          leading: Text(_schedules[index].dayOfWeek),
                          title: Text(
                              '${_schedules[index].startTime} - ${_schedules[index].endTime}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _schedules.removeAt(index);
                                // _schedules.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showAddScheduleDialog();
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add Schedule'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Map course = {
                                "course_name": _courseName,
                                "teacher": _selectedTeacher,
                                "schedules": _schedules
                                    .map((schedule) => {
                                          "dayOfTheWeek": schedule.dayOfWeek,
                                          "startTime": schedule.startTime,
                                          "endTime": schedule.endTime
                                        })
                                    .toList()
                              };
                              BlocProvider.of<CourseUpdateBloc>(context)
                                  .add(UpdateCourseEvent(
                                course,
                                state.course.courseId,
                                currentSchool!.id,token!
                              ));
                              _showUpdateCoursePopup(context);
                            }
                          },
                          child: Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CourseBloc>(context)
                                .add(DeleteCourseEvent(
                              state.course.courseId,
                              currentSchool!.id,
                              token
                            ));
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                );
              }

              if (state is CourseOperationFailure) {
                return Center(child: Text(state.error.toString()));
              } else if (state is DeleteCourseOperationSuccess) {
                return Center(child: Text("course successfully Deleted"));
              } else {
                return Center(child: Text("none"));
              }
            }),
          ),
        ),
      ),
    );
  }

  void _showAddScheduleDialog() {
    String _selectedDay = 'monday';
    _selectedStartTime = TimeOfDay.now();
    _selectedEndTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                value: _selectedDay,
                items: [
                  'monday',
                  'tuesday',
                  'wednesday',
                  'thursday',
                  'friday',
                  'saturday',
                  'sunday',
                ].map((day) {
                  return DropdownMenuItem(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDay = value.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Day',
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('Start Time'),
                trailing: Text(_selectedStartTime.format(context)),
                onTap: () {
                  _selectStartTime(context);
                },
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('End Time'),
                trailing: Text(_selectedEndTime.format(context)),
                onTap: () {
                  _selectEndTime(context);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _schedules.add(
                    Schedule(
                      dayOfWeek: _selectedDay,
                      startTime: _selectedStartTime.format(context),
                      endTime: _selectedEndTime.format(context),
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedStartTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedEndTime = pickedTime;
      });
    }
  }

  void _addNewSchedule() {
    // Implement your logic to add a new schedule to the list
    setState(() {
      // Here, you can replace the dummy values with actual input values or use a form to collect schedule data
      _schedules.add(Schedule(
        dayOfWeek: 'monday',
        startTime: '9:00 AM',
        endTime: '11:00 AM',
      ));
    });
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

void _showUpdateCoursePopup(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Course'),
        content: BlocBuilder<CourseUpdateBloc, CourseUpdateState>(
            builder: (context, state) {
          if (state is CourseUpdateOperationSuccess) {
            return Text("${state.course.courseName} is sucessfully updated");
          }
          if (state is CourseUpdateOperationFailure) {
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
