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

  JoinAsStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join as student"),
      backgroundColor: Color.fromARGB(255, 236, 217, 89),),
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

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(
                                'Join as Student',
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _userNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.3),
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
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.3),
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
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.3),
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
                                var authBloc =
                                    BlocProvider.of<AuthBloc>(context);
                                authBloc.add(
                                  JoinAsStudentAttemptEvent(
                                    userName: userName,
                                    userEmail: userEmail,
                                    password: password,
                                  ),
                                );
                              }
                            },
                            child: const Text('Join as Student'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
