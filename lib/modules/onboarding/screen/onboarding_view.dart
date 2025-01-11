import 'package:campus_crush/constants/assets.dart';
import 'package:campus_crush/core/app_text_styles.dart';
import 'package:campus_crush/core/color_scheme.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Onboarding Screen',
          style: AppTextStyles.monserrat600(
              fontSize: 12, color: AppColors.deepBlue),
        ),
      ),
      body: Center(
        child: Image.asset(Assets.imagesLogo),
      ),
    );
  }
}
