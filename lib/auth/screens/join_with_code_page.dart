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

  JoinWithCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join with Code'),
        backgroundColor: Color.fromARGB(255, 236, 217, 89),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state.isProcessing) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.authFailed) {
          return Center(
            child: Column(
              children: [
                Text('SignUp failed'),
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
                        TextFormField(
                          controller: _codeController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Code',
                            fillColor: Colors.black.withOpacity(0.3),
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            fillColor: Colors.black.withOpacity(0.3),
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _userEmailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'User Email',
                            fillColor: Colors.black.withOpacity(0.3),
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains("@")) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            fillColor: Colors.black.withOpacity(0.3),
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'The password length should be greater than 6';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final code = _codeController.text;
                              final userName = _userNameController.text;
                              final userEmail = _userEmailController.text;
                              final password = _passwordController.text;

                              var authBloc = BlocProvider.of<AuthBloc>(context);
                              authBloc.add(JoinWithCodeAttemptEvent(
                                code: code,
                                userName: userName,
                                userEmail: userEmail,
                                password: password,
                              ));
                            }
                          },
                          child: const Text('Join'),
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
    );
  }
}
