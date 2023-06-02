// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  late TextEditingController passwordCheckController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    passwordCheckController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    nameController.dispose();
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
            AuthField(controller: (nameController), hintText: 'name'),
            const SizedBox(
              height: 5,
            ),
            AuthField(controller: (emailController), hintText: 'email'),
            const SizedBox(
              height: 5,
            ),
            AuthField(
              controller: passwordController,
              hintText: 'password',
            ),
            const SizedBox(
              height: 5,
            ),
            AuthField(
              controller: passwordCheckController,
              hintText: 'confirm password',
            ),
            //textfield2
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: RoundedButton(
                label: "Signup",
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
                    recognizer: TapGestureRecognizer()..onTap = () {},
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

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      backgroundColor: Colors.black87);

  RoundedButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: () {},
      child: Text(label),
    );
  }
}

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
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
          borderSide: const BorderSide(color: Colors.black12),
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
      title: const Text('SignUp'),
      centerTitle: true,
      backgroundColor: Colors.deepPurple[100],
    );
  }
}
