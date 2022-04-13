import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mycrypto/app/core/theme/colors.dart';
import 'package:mycrypto/app/modules/auth/modules/login/login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        child: Center(
          child: Lottie.asset(
            'assets/app/logo_splash.json',
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.rotationTransition,
    );
  }
}
