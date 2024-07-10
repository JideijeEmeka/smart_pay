import 'package:flutter/material.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/widgets/onboarding_view1_widget.dart';
import 'package:smartpay/widgets/onboarding_view2_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: onBoardingScaffoldColor,
     body: PageView(
            controller: controller,
            onPageChanged: (index) {},
            children: [
          /// onboarding view 1
              onboardingView1Widget(context, controller),
              /// onboarding view 2
              onboardingView2Widget(context, controller)
    ]));
  }
}
