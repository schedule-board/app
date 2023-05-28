import 'package:flutter/material.dart';

class JoinAsOwnerPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _shoolEmailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  JoinAsOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join As Owner'),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            const Text("school Details"),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            TextFormField(
              controller: _schoolNameController,
              decoration: const InputDecoration(
                labelText: 'School Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the  School Name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _shoolEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'School email',
              ),
              validator: (value) {
                RegExp emailRegex = RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
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
            const Text("user Details"),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'User Name',
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
              decoration: const InputDecoration(
                labelText: 'User email',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                RegExp emailRegex = RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the password';
                }

                if (value.length < 6) {
                  return 'passwords should be longer than 6 characters';
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
                  final password = int.parse(_passwordController.text);

                  // Do something with the form data (e.g., save to database)
                  print('school_name : $shoolName');
                  print('school_email: $schoolEmail');

                  print('user_name: $userName');
                  print('user_email: $userEmail');
                  print('password: $password');
                }
              },
              child: const Text('Create Course'),
            ),
          ],
        ),
      )),
    );
  }
}
