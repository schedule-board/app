import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/states/auth_state.dart';

class JoinWithCodeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  JoinWithCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join with Code'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
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
                      context.read<AuthBloc>().add(JoinWithCodeAttemptEvent(
                            code: _codeController.text,
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
                TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Code',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid code';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    labelText: 'username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _userEmailController,
                  decoration: const InputDecoration(
                    labelText: 'user email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains("@")) {
                      return 'please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'the password length should be greater than 6';
                    }

                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, perform desired actions here
                      final code = _codeController.text;
                      final userName = _userNameController.text;
                      final userEmail = _userEmailController.text;
                      final password = _passwordController.text;

                      // add join as student attempt event to the bloc
                      var authBloc = BlocProvider.of<AuthBloc>(context);
                      authBloc.add(JoinWithCodeAttemptEvent(code: code, userName: userName, userEmail: userEmail, password: password));
                    }
                  },
                  child: const Text('Join'),
                ),
              ],
            ),
          ));
        }
      ),
    );
  }
}
