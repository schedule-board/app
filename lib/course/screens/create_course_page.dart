import 'package:flutter/material.dart';
import 'package:schedule/teacher/bloc/bloc.dart';
import '../bloc/bloc.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class CreateCoursePage extends StatefulWidget {
  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();

  final TextEditingController _creditHourController = TextEditingController();

  final TextEditingController _ectsController = TextEditingController();

  String? _courseName;

  String? _selectedTeacherid;

  late TimeOfDay _selectedStartTime = TimeOfDay.now();
  late TimeOfDay _selectedEndTime = TimeOfDay.now();

  List<Schedule> _schedules = [];
  List _teachers = [];

  @override
  Widget build(BuildContext context) {
    List teachers = context.watch<TeacherBloc>().state.props;

    if (teachers.length != 0) {
      _teachers = teachers[0];
    }

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<CourseBloc>(context).add(LoadCourseEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Course'),
        ),
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(
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
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Teacher',
                ),
                value: _selectedTeacherid,
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
                    _selectedTeacherid = value as String?;
                  });
                },
                onSaved: (value) {
                  _selectedTeacherid = value as String?;
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
                  final schedule = _schedules[index];
                  return ListTile(
                    leading: Text(schedule.dayOfWeek),
                    title: Text('${schedule.startTime} - ${schedule.endTime}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _schedules.removeAt(index);
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Map course = {
                      "course_name": _courseName,
                      "teacher": _selectedTeacherid,
                      "schedules": _schedules
                          .map((schedule) => {
                                "dayOfTheWeek": schedule.dayOfWeek,
                                "startTime": schedule.startTime,
                                "endTime": schedule.endTime
                              })
                          .toList()
                    };
                    BlocProvider.of<CourseBloc>(context).add(
                        CreateCourseEvent(course, "646a2b183748bfedb7cb7819"));
                    _showCreateCoursePopup(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        )),
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
        dayOfWeek: 'Monday',
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

void _showCreateCoursePopup(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create Course'),
        content:
            BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
          if (state is OneCourseOperationSuccess) {
            return Text("${state.course.courseName} is sucessfully created");
          }
          if (state is CourseOperationFailure) {
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
