import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupScreen extends StatefulWidget {
  const PopupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PopupScreenState createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Class'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textFieldController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Form Field',
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // send the req 

            }
          },
          child:const  Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
