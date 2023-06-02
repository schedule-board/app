import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule/auth/screens/onboarding/welcomepage/components/background.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 236, 217, 89),
          title: const Text('Sign up page'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Background(
          child: Center(
            child: FractionallySizedBox(
              alignment: Alignment.center,
              heightFactor: 0.5,
              child: Card(
                color: Colors.white.withOpacity(
                    0.8), // Add transparency to the card's background color
                elevation: 8, // Add a shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Round the card's corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.push('/joinAsOwner');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .blue, // Change the button's background color
                          onPrimary:
                              Colors.white, // Change the button's text color
                          elevation:
                              0, // Remove the shadow effect from the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Round the button's corners
                          ),
                        ),
                        child: const Text('Join as owner'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/joinAsStudent');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .green, // Change the button's background color
                          onPrimary:
                              Colors.white, // Change the button's text color
                          elevation:
                              0, // Remove the shadow effect from the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Round the button's corners
                          ),
                        ),
                        child: const Text('Join as a student'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/joinWithCode');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .orange, // Change the button's background color
                          onPrimary:
                              Colors.white, // Change the button's text color
                          elevation:
                              0, // Remove the shadow effect from the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Round the button's corners
                          ),
                        ),
                        child: const Text('Join with Code'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
