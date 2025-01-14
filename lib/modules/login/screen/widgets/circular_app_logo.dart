import 'package:campus_crush/constants/assets.dart';
import 'package:campus_crush/core/screen_responsive.dart';
import 'package:flutter/material.dart';

class CircularAppLogo extends StatelessWidget {
  const CircularAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(((context.screenWidth * 0.7))),
      child: Image.asset(
        Assets.imagesC2Logo,
        height: context.screenWidth * 0.7,
      ),
    );
  }
}
