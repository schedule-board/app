import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schedule/signup.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appBar = UIconstants.appBar();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            //textfield 1
            AuthField(controller: (emailController), hintText: 'email'),
            const SizedBox(
              height: 25,
            ),
            AuthField(
              controller: passwordController,
              hintText: 'password',
            ),
            const SizedBox(
              height: 40,
            ),
            //textfield2

            Align(
              alignment: Alignment.topRight,
              child: RoundedSmallButton(
                label: "done",
                onTap: () {},
              ),
            ),
            RichText(
              text: TextSpan(
                text: "don't have an account?",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                      text: 'SignUp',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            SignUpView.route(),
                          );
                        }),
                ],
              ),
            ),

            //button
            //textspan
          ]),
        ),
      ),
    );
  }
}

class RoundedSmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const RoundedSmallButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
    );
  }
}

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final hintText;
  const AuthField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        contentPadding: const EdgeInsets.all(
          22,
        ),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
