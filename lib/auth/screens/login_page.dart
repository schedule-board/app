import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/states/auth_state.dart';
import '../../schedule/bloc/bloc.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.isProcessing) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.authFailed) {
              return Center(
                child: Column(
                  children: [
                    Text('Login failed'),
                    // retry button
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(AuthProcessingStartEvent());
                        context.read<AuthBloc>().add(LoginAttemptEvent(
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
                    Text('Login success'),
                    // go to home button
                    ElevatedButton(
                      onPressed: () {
                        if (state.user!.role == "teacher") {
                          BlocProvider.of<ScheduleBloc>(context).add(
                              LoadScheduleEvent({
                            "teacher": state.user!.userId,
                            "token": state.token
                          }));
                        }
                        if (state.user!.role == "owner" ||
                            state.user!.role == "coordinator") {
                          BlocProvider.of<ScheduleBloc>(context).add(
                              LoadScheduleEvent({
                            "school": state.school!.id,
                            "token": state.token
                          }));
                        }

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
                          'Login',
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
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
                          final userName = _userEmailController.text;
                          final password = _passwordController.text;

                          // add login event to the bloc
                          var authBloc = BlocProvider.of<AuthBloc>(context);
                          authBloc.add(LoginAttemptEvent(
                              userEmail: userName, password: password));
                        }
                      },
                      child: const Text('Login'),
                    ),
                    // text button to go to sign up page
                    TextButton(
                      onPressed: () {
                        context.push('/signUp');
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
