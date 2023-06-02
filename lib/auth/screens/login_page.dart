import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/screens/onboarding/welcomepage/components/background.dart';
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
      body: Center(
        child: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.isProcessing) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.authFailed) {
                return Expanded(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/login failed.jpg',
                        // fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Card(
                          color: Colors.black.withOpacity(0.5),
                          shadowColor: Colors.black.withOpacity(0.5),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              const Text(
                                'Login failed',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthProcessingStartEvent());
                                  context
                                      .read<AuthBloc>()
                                      .add(LoginAttemptEvent(
                                        userEmail: _userEmailController.text,
                                        password: _passwordController.text,
                                      ));
                                },
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Retry button
                    ],
                  ),
                );
              } else if (state.user != null) {
                return Background(
                  child: Center(
                    child: Column(
                      children: [
                        const Text('Login success'),
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
                  ),
                );
              }

              return Background(
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.5), // Use a translucent black color
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 26, color: Colors.black),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _userEmailController,
                                  style: TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
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
                                  style: TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
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
                                      final userName =
                                          _userEmailController.text;
                                      final password = _passwordController.text;

                                      // Add login event to the bloc
                                      var authBloc =
                                          BlocProvider.of<AuthBloc>(context);
                                      authBloc.add(LoginAttemptEvent(
                                        userEmail: userName,
                                        password: password,
                                      ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  child: const Text('Login',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                // Text button to go to sign-up page
                                TextButton(
                                  onPressed: () {
                                    context.push('/signUp');
                                  },
                                  style: TextButton.styleFrom(
                                      primary: Colors.black),
                                  child: const Text('Sign Up'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
