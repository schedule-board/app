import 'package:flutter/material.dart';
import '../../Login/components/login_screen_top_image.dart';


import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
    this.mainImage = "assets/svgs/background.svg",
  }) : super(key: key);

  final String topImage, bottomImage, mainImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity, // Set the height to infinity
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: SvgPicture.asset(
                mainImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
