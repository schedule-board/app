import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/class/bloc/bloc.dart';
import 'package:schedule/schedule/bloc/bloc.dart';
import 'package:schedule/schedule/bloc/schedule_bloc.dart';
import "../course/bloc/bloc.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/states/auth_state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Schedule Board';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: LandingPage(title: appTitle),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var currentSchool = context.watch<AuthBloc>().state.school;
    var token = context.watch<AuthBloc>().state.token;
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
                onTap: () {},
              ));
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
                    Navigator.pop(context);
                  },
                ),
              if (state.user?.role == 'student')
                ListTile(
                  title: const Text('Select class'),
                  onTap: () {
                    BlocProvider.of<ClassBloc>(context)
                        .add(LoadAllClassesEvent(token!));
                    context.push('/selectClass');
                    Navigator.pop(context);
                  },
                ),
              if (state.user?.role != 'student')
                ListTile(
                  title: const Text('MY School'),
                  onTap: () {
                    context.push('/schoolDetail');
                    Navigator.of(context).pop();
                  },
                ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  context.push('/profile');
                  Navigator.of(context).pop();
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
                    Navigator.of(context).pop();
                  },
                ),
              if (state.user?.role == 'owner' ||
                  state.user?.role == 'coordinator')
                ListTile(
                  title: const Text('Manage Classes'),
                  onTap: () {
                    context.push('/classList');
                    Navigator.of(context).pop();
                    BlocProvider.of<ClassBloc>(context)
                        .add(LoadClassesEvent(currentSchool!.id, token!));
                  },
                ),
              // ListTile(
              //   title: const Text('Manage Courses'),
              //   onTap: () {
              //     BlocProvider.of<CourseBloc>(context).add(LoadCourseEvent());
              //     context.push('/courseList');
              //     Navigator.of(context).pop();
              //   },
              // ),
              // ListTile(
              //   title: const Text('Manage Classes'),
              //   onTap: () {
              //     context.push('/classList');
              //     Navigator.of(context).pop();
              //     BlocProvider.of<ClassBloc>(context).add(LoadClassesEvent());
              //   },
              // )
            ],
          );
        }),
      ),
    );
  }
}
