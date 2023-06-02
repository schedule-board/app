import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/screens/onboarding/welcomepage/components/background.dart';
import 'package:schedule/auth/states/auth_state.dart';

class JoinAsOwnerPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _shoolEmailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  JoinAsOwnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 236, 217, 89),
        title: const Text('Join As Owner'),
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

        return Background(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white
                    .withOpacity(0.8), // Translucent background color
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        const Text(
                          "school Details",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        TextFormField(
                          controller: _schoolNameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'School Name',
                            fillColor: Colors.black.withOpacity(
                                0.3), // Transparent background color
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the School Name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _shoolEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'School email',
                            fillColor: Colors.black.withOpacity(
                                0.3), // Transparent background color
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            RegExp emailRegex = RegExp(
                                r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
                            if (value == null || value.isEmpty) {
                              return 'Please enter the School email';
                            }
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        const Text(
                          "user Details",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        TextFormField(
                          controller: _userNameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'User Name',
                            fillColor: Colors.black.withOpacity(
                                0.3), // Transparent background color
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }

                            if (value.length < 3) {
                              return 'Please enter a valid username';
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _userEmailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'User email',
                            fillColor: Colors.black.withOpacity(
                                0.3), // Transparent background color
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            RegExp emailRegex = RegExp(
                                r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
                            if (value == null || value.isEmpty) {
                              return 'Please enter your school\'s email';
                            }
                            if (!emailRegex.hasMatch(value)) {
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
                            fillColor: Colors.black.withOpacity(
                                0.3), // Transparent background color
                            filled: true,
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the password';
                            }

                            if (value.length < 6) {
                              return 'Passwords should be longer than 6 characters';
                            }

                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 30)),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, perform desired actions here
                              final shoolName = _schoolNameController.text;
                              final schoolEmail = _shoolEmailController.text;
                              final userName = _userNameController.text;
                              final userEmail = _userEmailController.text;
                              final password = _passwordController.text;

                              // add join as student attempt event to the bloc
                              var authBloc = BlocProvider.of<AuthBloc>(context);
                              authBloc.add(JoinAsOwnerAttemptEvent(
                                schoolName: shoolName,
                                schoolEmail: schoolEmail,
                                userName: userName,
                                userEmail: userEmail,
                                password: password,
                              ));
                            }
                          },
                          child: const Text('join'),
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
