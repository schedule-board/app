import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/bloc/auth_bloc.dart';
import 'package:schedule/auth/states/auth_state.dart';

class ProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameDetailController =
      TextEditingController();
  final TextEditingController _userEmailDetailController =
      TextEditingController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primaryColor: Color.fromARGB(255, 208, 209, 209),
          hintColor: Color.fromARGB(255, 173, 173, 173),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("user Profile"),
          ),
          body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state.user == null) {
              return Center(
                  child: Column(
                children: [
                  const Text("You are successfully logged out"),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: const Text('Log In'),
                  ),
                ],
              ));
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 100)),
                  userEmailDetail(),
                  const Padding(padding: EdgeInsets.only(bottom: 60)),
                  userNameDetail(),
                  const Padding(padding: EdgeInsets.only(bottom: 100)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      editButton(context),
                      deleteButton(context),
                      logoutButton(context),
                    ],
                  ),
                ],
              ),
            );
          }),
        ));
  }

  Widget userEmailDetail() {
    return TextFormField(
      controller: _userEmailDetailController,
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

  Widget userNameDetail() {
    return TextFormField(
      controller: _userNameDetailController,
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

  Widget editButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // send the date to the server
          final String userName = _userNameDetailController.text;
          final String userEmail = _userEmailDetailController.text;
        }
      },
      child: const Text('Edit user'),
    );
  }

  Widget deleteButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Delete user'),
    );
  }

  Widget logoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AuthBloc authbloc = BlocProvider.of<AuthBloc>(context);
        authbloc.add(LogoutEvent());
      },
      child: const Text('Log out'),
    );
  }

  static const String emailDetailHintText = 'user email';
  static const String nameDetailHintText = 'user name';
}
