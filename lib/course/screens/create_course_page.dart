import 'package:flutter/material.dart';

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

  String? _selectedTeacher;

  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  List<String> _teachers = [
    'Teacher 1',
    'Teacher 2',
    'Teacher 3',
  ];

  List<Schedule> _schedules = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                value: _selectedTeacher,
                items: _teachers.map((String teacher) {
                  return DropdownMenuItem(
                    value: teacher,
                    child: Text(teacher),
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
                    _selectedTeacher = value;
                  });
                },
                onSaved: (value) {
                  _selectedTeacher = value;
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
                    // Perform submit action here
                    print('Course Name: $_courseName');
                    print('Selected Teacher: $_selectedTeacher');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddScheduleDialog() {
    String _selectedDay = 'Monday';
    TimeOfDay _selectedStartTime = TimeOfDay.now();
    TimeOfDay _selectedEndTime = TimeOfDay.now();

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
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday',
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
