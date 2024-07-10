import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/views/sign_in_view.dart';
import 'package:smartpay/widgets/button_widget.dart';

class CongratulationsView extends StatefulWidget {
  const CongratulationsView({super.key});

  @override
  State<CongratulationsView> createState() => _CongratulationsViewState();
}

class _CongratulationsViewState extends State<CongratulationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/congrats_logo.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('Congratulations, James ',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: mainColor
                  )),
            ),
            Text('You’ve completed the onboarding,\nyou can start using ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: lightGreyColor
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: buttonWidget(onTap: () {
                pushScreen(context, screen: const SignInView());
              },
                  text: 'Get Started'),
            )
          ],
        ),
      ),
    );
  }
}
