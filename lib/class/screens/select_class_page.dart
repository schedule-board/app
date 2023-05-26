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
        child: BlocBuilder<SelectClassBloc, ClassState>(
          builder: (context, state) {
            if (state is ClassLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SelectClassOperationSuccess) {
              return ListView.builder(
                  itemBuilder: (context, index) => Card(
                        elevation: 3,
                        child: InkWell(
                          onTap: () {},
                          child: CheckboxListTile(
                            onChanged: (value) => {},
                            value: false,
                            title: Text(
                              state.classesToSelect[index].className,
                            ),
                          ),
                        ),
                      ),
                  itemCount: state.classesToSelect.length);
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
          BlocProvider.of<SelectClassBloc>(context).add(LoadSelectClassEvent());
        },
      ),
    );
  }
}
