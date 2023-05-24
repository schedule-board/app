import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/class_bloc.dart';
import '../bloc/class_state.dart';
import '../bloc/class_event.dart';

class SelectClassPage extends StatelessWidget {
  const SelectClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Class")),
      body: Center(
        child: BlocBuilder<ClassBloc, ClassState>(
          builder: (context, state) {
            if (state is ClassLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ClassesOperationSuccess) {
              return ListView.builder(
                  itemBuilder: (context, index) => Card(
                        elevation: 3,
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: const Icon(Icons.school),
                            title: Text(
                              state.classes[index].courseName,
                            ),
                            subtitle: Text(state.classes[index].schoolName,
                                style: const TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                  itemCount: state.classes.length);
            }

            if (state is ClassOperationFailure) {
              return Center(child: Text(state.error.toString()));
            } else {
              return Center(child: Text("none"));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ClassBloc>(context).add(LoadClassEvent());
        },
      ),
    );
  }
}
