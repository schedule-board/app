import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

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
                    'Login',
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

                    // Do something with the form data (e.g., save to database)
                    print('Username: $userName');
                    print('Password: $password');
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
