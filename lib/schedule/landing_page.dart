import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/class/bloc/bloc.dart';
import 'package:schedule/schedule/bloc/bloc.dart';
import 'package:schedule/schedule/bloc/schedule_bloc.dart';
import 'package:schedule/schedule/bloc/schedule_updateBloc.dart';
import "../course/bloc/bloc.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/states/auth_state.dart';
import "package:intl/intl.dart";
import "./models/schedules_Amodel.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Schedule Board';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: LandingPage(title: appTitle),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({super.key, required this.title});

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String? _courseName;

  String? _selectedTeacher;

  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  @override
  Widget build(BuildContext context) {
    var currentSchool = context.watch<AuthBloc>().state.school;
    var token = context.watch<AuthBloc>().state.token;
    var user = context.watch<AuthBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Text('Hello ${state.user?.userName ?? "user"}');
          },
        ),
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(builder: (context, state) {
        if (state is ScheduleLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ScheduleOperationSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                      isThreeLine: true,
                      leading: const Icon(Icons.timelapse),
                      title: Text(state.schedules[index].courseName),
                      subtitle: Text(
                          '${state.schedules[index].day} , ${state.schedules[index].startTime} - ${state.schedules[index].endTime}'),
                      trailing: SizedBox(
                        width: 80,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (["teacher", "owner", "coordinator"]
                                  .contains(user!.role))
                                IconButton(
                                    onPressed: () {
                                      _showAddScheduleDialog(
                                          state.schedules, index, token);
                                    },
                                    icon: Icon(Icons.edit)),
                              if (["owner", "coordinator"].contains(user.role))
                                IconButton(
                                    onPressed: () {
                                      _showDeleteScheduleDialog(
                                          state.schedules, index, token);
                                    },
                                    icon: Icon(Icons.delete))
                            ]),
                      )));
            },
            itemCount: state.schedules.length,
          );
        }
        if (state is ScheduleOperationFailureState) {
          return Center(child: Text(state.error.toString()));
        } else {
          return const Center(child: Text("Select Class to see Schedules"));
        }
      }),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Schedule board'),
              ),
              if (state.user?.role != 'student')
                ListTile(
                  title: const Text('Invite'),
                  onTap: () {
                    context.push('/invite');
                  },
                ),
              if (state.user?.role == 'student')
                ListTile(
                  title: const Text('Select class'),
                  onTap: () {
                    BlocProvider.of<ClassBloc>(context)
                        .add(LoadAllClassesEvent(token!));
                    context.push('/selectClass');
                  },
                ),
              if (state.user?.role != 'student')
                ListTile(
                  title: const Text('MY School'),
                  onTap: () {
                    context.push('/schoolDetail');
                  },
                ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  context.push('/profile');
                },
              ),
              if (state.user?.role == 'owner' ||
                  state.user?.role == 'coordinator')
                ListTile(
                  title: const Text('Manage Courses'),
                  onTap: () {
                    BlocProvider.of<CourseBloc>(context)
                        .add(LoadCourseEvent(currentSchool?.id, token));
                    context.push('/courseList');
                  },
                ),
              if (state.user?.role == 'owner' ||
                  state.user?.role == 'coordinator')
                ListTile(
                  title: const Text('Manage Classes'),
                  onTap: () {
                    context.push('/classList');

                    BlocProvider.of<ClassBloc>(context)
                        .add(LoadClassesEvent(currentSchool!.id, token!));
                  },
                ),
            ],
          );
        }),
      ),
    );
  }

  void _showAddScheduleDialog(schedules, index, token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CoustomAlartDailog(
          schedules: schedules,
          index: index,
          selectedEndTime: null,
          selectedStartTime: null,
          token: token,
          showUpdateSchedulePopup: _showUpdateSchedulePopup,
        );
      },
    );
  }

  void _showDeleteScheduleDialog(schedules, index, token) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                "Are you sure! you want delete the schedule of ${schedules[index].courseName}"),
            actions: [
              TextButton(
                onPressed: () {
                  BlocProvider.of<ScheduleDeleteBloc>(context).add(
                      DeleteScheduleEvent(schedules[index].scheduleId, token));

                  _showDeleteSchedulePopup(context, schedules, index);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  void _showUpdateSchedulePopup(context, schedules, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Course'),
          content: BlocBuilder<ScheduleUpdateBloc, ScheduleUpdateState>(
              builder: (context, state) {
            if (state is ScheduleUpdateOperationSuccess) {
              schedules[index].day = state.schedule.day;
              schedules[index].startTime = state.schedule.startTime;
              schedules[index].endTime = state.schedule.endTime;
              BlocProvider.of<ScheduleBloc>(context)
                  .add(RanderSchedule(schedules));
              return const Text("Schedule is sucessfully updated");
            }
            if (state is ScheduleUpdateOperationFailure) {
              return Text("Error ocurr on update:\n ${state.error.toString()}");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class CoustomAlartDailog extends StatefulWidget {
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  List<dynamic> schedules;
  int index;
  String token;
  Function showUpdateSchedulePopup;
  CoustomAlartDailog({
    super.key,
    required this.schedules,
    required this.index,
    required this.selectedEndTime,
    required this.selectedStartTime,
    required this.token,
    required this.showUpdateSchedulePopup,
  });

  @override
  State<CoustomAlartDailog> createState() => _CoustomAlartDailogState();
}

class _CoustomAlartDailogState extends State<CoustomAlartDailog> {
  late String selectedDay;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  void init() {
    selectedDay = widget.schedules[widget.index].day;
    selectedStartTime = widget.selectedEndTime;
    selectedEndTime = widget.selectedEndTime;
  }

  bool initalBulid = true;
  @override
  Widget build(BuildContext context) {
    if (initalBulid) {
      init();
      initalBulid = false;
    }

    return AlertDialog(
      title: const Text('Add Schedule'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
            value: selectedDay,
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
                selectedDay = value.toString();
              });
            },
            decoration: const InputDecoration(
              labelText: 'Day',
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('Start Time'),
            trailing: Text(selectedStartTime == null
                ? widget.schedules[widget.index].startTime
                : selectedStartTime!.format(context)),
            onTap: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  selectedStartTime = pickedTime;
                });
              }
            },
          ),
          ListTile(
            title: const Text('End Time'),
            trailing: Text(selectedEndTime == null
                ? widget.schedules[widget.index].endTime
                : selectedEndTime!.format(context)),
            onTap: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  selectedEndTime = pickedTime;
                });
              }
            },
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Map newSchedule = {
              "dayOfTheWeek": selectedDay,
              "startTime": selectedStartTime == null
                  ? widget.schedules[widget.index].startTime
                  : selectedStartTime!.format(context),
              "endTime": selectedEndTime == null
                  ? widget.schedules[widget.index].endTime
                  : selectedEndTime!.format(context)
            };
            BlocProvider.of<ScheduleUpdateBloc>(context).add(
                UpdateScheduleEvent(newSchedule,
                    widget.schedules[widget.index].scheduleId, widget.token));

            widget.showUpdateSchedulePopup(
                context, widget.schedules, widget.index);
          },
          child: Text('update'),
        ),
      ],
    );
  }
}

void _showDeleteSchedulePopup(context, schedules, index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('delete Schedule dialog'),
        content: BlocBuilder<ScheduleDeleteBloc, ScheduleDeleteState>(
            builder: (context, state) {
          if (state is ScheduleDeleteOperationSuccess) {
            schedules.removeAt(index);
            BlocProvider.of<ScheduleBloc>(context)
                .add(RanderSchedule(schedules));
            return const Text("Schedule is sucessfully deleted");
          }
          if (state is ScheduleDeleteOperationFailure) {
            return Text("Error ocurr on update:\n ${state.error.toString()}");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
