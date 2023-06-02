import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 5000),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.black,
         
        ),
        child: Text("Schedule Board"),
      ),
        SizedBox(height: defaultPadding * 2),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
