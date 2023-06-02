import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import '../models/course_model.dart';
import '../bloc/bloc.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import '../../teacher/bloc/bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../schedule/bloc/bloc.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var currentSchool = context.watch<AuthBloc>().state.school;
    var token = context.watch<AuthBloc>().state.token;
    var user = context.watch<AuthBloc>().state.user;
    return WillPopScope(
      onWillPop: () async {
        if (user!.role == "teacher") {
          BlocProvider.of<ScheduleBloc>(context)
              .add(LoadScheduleEvent({"teacher": user.userId, "token": token}));
        }
        if (user.role == "owner" || user.role == "coordinator") {
          BlocProvider.of<ScheduleBloc>(context).add(
              LoadScheduleEvent({"school": currentSchool!.id, "token": token}));
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("course List"),
        ),
        body: SingleChildScrollView(
            child: Container(
                height: 500,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<CourseBloc, CourseState>(
                    builder: (context, state) {
                  if (state is CoursesOperationSuccess) {
                    return ListView.builder(
                        itemBuilder: (context, index) {
                          Course course = state.courses[index];
                          return Card(
                            elevation: 3,
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<TeacherBloc>(context)
                                    .add(LoadTeacherEvent(currentSchool!.id));
                                BlocProvider.of<CourseBloc>(context).add(
                                    LoadOneCourseEvent(currentSchool.id,
                                        course.courseId, token!));
                                context.push("/courseDetail");
                              },
                              child: ListTile(
                                leading: const Icon(Icons.school),
                                title: Text(course.courseName),
                                subtitle: Text(course.schoolName!,
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                            ),
                          );
                        },
                        itemCount: state.courses.length);
                  } else if (state is CourseOperationFailure) {
                    return Center(child: Text(state.error.toString()));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                  ;
                }))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<TeacherBloc>(context)
                .add(LoadTeacherEvent(currentSchool!.id));

            context.push('/createCourse');
            // Navigator.of(context).pop();
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
