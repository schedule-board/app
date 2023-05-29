import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/course/bloc/bloc.dart';
import '../bloc/class_bloc.dart';
import '../bloc/class_event.dart';
import '../bloc/class_state.dart';
import '../models/class_model.dart';
import 'package:go_router/go_router.dart';
import '../../auth/bloc/auth_bloc.dart';

class ManageClassPage extends StatefulWidget {
  const ManageClassPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManageClassPageState createState() => _ManageClassPageState();
}

class _ManageClassPageState extends State<ManageClassPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentSchool = context.watch<AuthBloc>().state.school;
    var token = context.watch<AuthBloc>().state.token;
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Class")),
      body: BlocBuilder<ClassBloc, ClassState>(
        builder: (context, state) {
          if (state is ClassesOperationSuccess) {
            var classs = state.classes;
            return ListView.builder(
              itemBuilder: (context, index) => Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<CourseBloc>(context)
                        .add(LoadCourseEvent(currentSchool!.id,token));
                    BlocProvider.of<ClassBloc>(context).add(LoadOneClassEvent(
                        state.classes[index].classId, currentSchool.id,token!));
                    context.push("/classDetail");
                  },
                  child: ListTile(
                    leading: const Icon(Icons.school),
                    title: Text(classs[index].className),
                    subtitle: Text(classs[index].schoolName!,
                        style: const TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              itemCount: state.classes.length,
            );
          }

          if (state is ClassOperationFailure) {
            return Center(child: Text(state.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text("ADD Class"),
            tooltip: ("ADD Class"),
            onPressed: () {
              BlocProvider.of<CourseBloc>(context)
                  .add(LoadCourseEvent(currentSchool!.id,token));
              context.push("/createClass");
            },
          ),
        ],
      ),
    );
  }
}
