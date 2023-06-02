import 'package:flutter/material.dart';

import '../responsive.dart';
import '../welcomepage/welcome_image.dart';
import '../welcomepage/components/background.dart';
// import '../welcomepage/welcome_screen.dart';
import '../welcomepage/login_signup_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WelcomeImage(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: LoginAndSignupBtn(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            mobile: MobileWelcomeScreen(),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // WelcomeImage(),
        Row(
          children: [
            Spacer(),
            Align(
                alignment: Alignment.bottomCenter, child: LoginAndSignupBtn()),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
