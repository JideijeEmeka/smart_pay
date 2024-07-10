import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smartpay/controller/auth_controller.dart';
import 'package:smartpay/helpers/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  AuthController authController = AuthController();

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      authController.checkAuthStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: authController.scaffoldKey,
      backgroundColor: scaffoldColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset('assets/images/logo.png'),
            ),
            RichText(text:
              TextSpan(
                text: 'Smart',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w600
                ),
                children:  [
                TextSpan(
                  text: 'pay.',
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600
                  ),
                )
            ]))
          ],
        ),
      ),
    );
  }
}
