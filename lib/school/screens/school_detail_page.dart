import 'package:flutter/material.dart';

class SchoolDetailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _schoolNameDetailController =
      TextEditingController();
  final TextEditingController _shoolEmailDetailController =
      TextEditingController();

  SchoolDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primaryColor: Color.fromARGB(255, 208, 209, 209),
          hintColor: Color.fromARGB(255, 173, 173, 173),
          brightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("School Details"),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 100)),
                schoolEmailDetail(),
                const Padding(padding: EdgeInsets.only(bottom: 60)),
                schoolNameDetail(),
                const Padding(padding: EdgeInsets.only(bottom: 100)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    editButton(),
                    deleteButton(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget schoolEmailDetail() {
    return TextFormField(
      controller: _shoolEmailDetailController,
      decoration: const InputDecoration(
        hintText: emailDetailHintText,
      ),
      style: const TextStyle(
        color: Color.fromARGB(255, 142, 138, 138),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      textAlign: TextAlign.justify,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the School email';
        }
        return null;
      },
    );
  }

  Widget schoolNameDetail() {
    return TextFormField(
      controller: _schoolNameDetailController,
      decoration: const InputDecoration(
        hintText: nameDetailHintText,
      ),
      style: const TextStyle(
        color: Color.fromARGB(255, 142, 138, 138),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      textAlign: TextAlign.justify,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the  School Name';
        }
        return null;
      },
    );
  }

  Widget editButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // send the date to the server
          final String schoolName = _schoolNameDetailController.text;
          final String schoolEmail = _shoolEmailDetailController.text;
          
        }
      },
      child: const Text('Edit school'),
    );
  }

  Widget deleteButton() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Delete shool'),
    );
  }

  static const String emailDetailHintText = 'school email';
  static const String nameDetailHintText = 'school name';
}
