import 'package:flutter/material.dart';

class CreateCourseScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _creditHourController = TextEditingController();
  final TextEditingController _ectsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Course'),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Course Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the course title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Course Code',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the course code';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _creditHourController,
              decoration: const InputDecoration(
                labelText: 'Credit Hour',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the credit hour';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ectsController,
              decoration: const InputDecoration(
                labelText: 'ECTS',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the ECTS';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, perform desired actions here
                  final title = _titleController.text;
                  final code = _codeController.text;
                  final creditHour = int.parse(_creditHourController.text);
                  final ects = int.parse(_ectsController.text);

                  // Do something with the form data (e.g., save to database)
                  print('Course Title: $title');
                  print('Course Code: $code');
                  print('Credit Hour: $creditHour');
                  print('ECTS: $ects');
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
