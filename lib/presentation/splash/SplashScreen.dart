import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/SignIn.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/WelcomeScreen.dart';

import '../../data/model/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBG,
      body: Center(
        child: Image.asset(
          AppImages.logoPath,
          height: 70,
          width: 200,
        )
      )
    );
  }
  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WelcomeScreen(),
      ),
    );
  }
}
