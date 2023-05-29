import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/states/auth_state.dart';

class JoinAsStudentPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  JoinAsStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join as student")),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state.isProcessing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.authFailed) {
            return Center(
              child: Column(
                children: [
                  Text('SignUp failed'),
                  // retry button
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthProcessingStartEvent());
                      context.read<AuthBloc>().add(JoinAsStudentAttemptEvent(
                            userName: _userNameController.text,
                            userEmail: _userEmailController.text,
                            password: _passwordController.text,
                          ));
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state.user != null) {
            return Center(
              child: Column(
                children: [
                  Text('SignUp success'),
                  // go to home button
                  ElevatedButton(
                    onPressed: () {
                      context.go('/landing');
                    },
                    child: Text('Go to home'),
                  ),
                ],
              ),
            );
          }

          return Center(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Join as Student',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _userEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, perform desired actions here
                      final userName = _userNameController.text;
                      final password = _passwordController.text;
                      final userEmail = _userEmailController.text;

                      // add join as student attempt event to the bloc
                      var authBloc = BlocProvider.of<AuthBloc>(context);
                      authBloc.add(JoinAsStudentAttemptEvent(
                          userName: userName,
                          userEmail: userEmail,
                          password: password));
                    }
                  },
                  child: const Text('Join as Student'),
                ),
              ],
            ),
          ));
        }),
      ),
    );
  }
}
