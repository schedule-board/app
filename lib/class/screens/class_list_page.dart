import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/class_bloc.dart';
import '../bloc/class_event.dart';
import '../bloc/class_state.dart';
import '../models/class_model.dart';

class ManageClassPage extends StatelessWidget {
  ManageClassPage({super.key});

  List classes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Class")),
      body: Center(
        child: BlocBuilder<ManageClassBloc, ClassState>(
          builder: (context, state) {
            if (state is ClassLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ManageClassOperationSuccess) {
              return ListView.builder(
                  itemBuilder: (context, index) => Card(
                        elevation: 3,
                        child: InkWell(
                          onTap: () {},
                          child: CheckboxListTile(
                            onChanged: (value) => {},
                            value: false,
                            title: Text(
                              state.classesToManage[index].className,
                            ),
                          ),
                        ),
                      ),
                  itemCount: state.classesToManage.length);
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
          BlocProvider.of<ManageClassBloc>(context).add(LoadManageClassEvent());
        },
      ),
    );
  }
}
