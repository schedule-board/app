import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/class_bloc.dart';
import '../bloc/class_state.dart';
import '../bloc/class_event.dart';
import "../../schedule/bloc/bloc.dart";
import "../../auth/bloc/auth_bloc.dart";

class SelectClassPage extends StatefulWidget {
  SelectClassPage({super.key});

  @override
  State<SelectClassPage> createState() => _SelectClassPageState();
}

class _SelectClassPageState extends State<SelectClassPage> {
  List<List> _selectedClass = [];

  // bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    var token = context.watch<AuthBloc>().state.token;
    return WillPopScope(
      onWillPop: () async {
        var selectedCourses = [];
        for (var courses in _selectedClass) {
          selectedCourses = selectedCourses + courses;
        }

        BlocProvider.of<ScheduleBloc>(context).add(
            LoadScheduleEvent({"courses": selectedCourses, "token": token}));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Select Class")),
        body: Center(
          child: BlocBuilder<ClassBloc, ClassState>(
            builder: (context, state) {
              if (state is ClassesOperationSuccess) {
                return ListView.builder(
                    itemBuilder: (context, index) => Card(
                          elevation: 3,
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(Icons.class_),
                              title: Text(state.classes[index].className),
                              subtitle: Text(state.classes[index].schoolName!,
                                  style: const TextStyle(color: Colors.grey)),
                              trailing: Checkbox(
                                value: state.classes[index].isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    state.classes[index].isSelected = value;
                                  });

                                  if (value!) {
                                    _selectedClass
                                        .add(state.classes[index].courses);
                                  } else {
                                    _selectedClass
                                        .remove(state.classes[index].courses);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                    itemCount: state.classes.length);
              }
              if (state is ClassOperationFailure) {
                return Center(child: Text(state.error.toString()));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
