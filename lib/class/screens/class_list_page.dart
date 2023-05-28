import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/class_bloc.dart';
import '../bloc/class_event.dart';
import '../bloc/class_state.dart';
import '../models/class_model.dart';

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
    BlocProvider.of<ManageClassBloc>(context).add(const LoadManageClassEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Class")),
      body: BlocBuilder<ManageClassBloc, ClassState>(
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
              itemCount: state.classesToManage.length,
            );
          }

          if (state is ClassOperationFailure) {
            return Center(child: Text(state.error.toString()));
          } else {
            return Center(child: Text("none"));
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
            },
          ),
        ],
      ),
    );
  }
}
