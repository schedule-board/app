import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import '../models/course_model.dart';
import '../bloc/bloc.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("course List"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
            if (state is CourseLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CoursesOperationSuccess) {
              return ListView.builder(
                  itemBuilder: (context, index) => Card(
                        elevation: 3,
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: const Icon(Icons.school),
                            title: Text(
                              state.courses[index].courseName,
                            ),
                            subtitle: Text(state.courses[index].schoolName,
                                style: const TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                  itemCount: state.courses.length);
            }

            if (state is CourseOperationFailure) {
              return Center(child: Text(state.error.toString()));
            } else {
              return Center(child: Text("none"));
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<CourseBloc>(context).add(LoadCourseEvent());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
