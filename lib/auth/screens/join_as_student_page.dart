import 'package:flutter/material.dart';

class JoinAsStudentPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  JoinAsStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                controller: _userNameController,
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
                    final email = _emailController.text;

                    // Do something with the form data (e.g., save to database)
                    print('Username: $userName');
                    print('Password: $password');
                    print('Email: $email');
                  }
                },
                child: const Text('Join as Student'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
