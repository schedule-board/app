import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Hello ${authBloc.state.user!.userName}')),
        body: Center(
          child: Column(
            children: [
              Text('Hello ${authBloc.state.user!.userName}'),
              ElevatedButton(
                onPressed: () {
                  authBloc.add(LogoutEvent());
                },
                child: const Text('Log Out'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Create class'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/createCourse');
                },
                child: const Text('Create course'),
              ),
            ],
          ),
        ));
  }
}
