import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
                text: "Already have an account?",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          LoginView.route(),
                        );
                      },
                  ),
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
          borderSide: const BorderSide(color: Colors.grey),
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

class UIconstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        'images/logo.png',
        color: Colors.amber,
        height: 30,
      ),
      centerTitle: true,
    );
  }
}
