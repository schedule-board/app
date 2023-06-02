import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import '../../profile_page.dart';
import '../../login_page.dart';
import '../../signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 183, 99, 21)),
              visualDensity: VisualDensity.compact,
            ),
            onPressed: () {
              context.push('/login');
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 183, 99, 21)),
            visualDensity: VisualDensity.compact,
          ),
          onPressed: () {
            context.push('/signUp');
          },
          child: Text(
            "Signup".toUpperCase(),
          ),
        ),
      ],
    );
  }
}
