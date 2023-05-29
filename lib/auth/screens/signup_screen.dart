import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      //make it at acenter from the top

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign up page'),
        ),
        body: Center(
          child: FractionallySizedBox(
            alignment: Alignment.center,
            heightFactor: 0.5,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.push('/joinAsOwner');
                  },
                  child: const Text('Join as owner'),
                ),
                //create a space between the buttons
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push('/joinAsStudent');
                  },
                  child: const Text('Join as a student'),
                ),
                //create a space between the buttons
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push('/joinWithCode');
                  },
                  child: const Text('Join with Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
