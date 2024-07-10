import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/views/sign_in_view.dart';
import 'package:smartpay/widgets/button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget onboardingView2Widget(BuildContext context, PageController controller) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {
                  pushScreen(context, screen: const SignInView());
                },
                  style: TextButton.styleFrom(
                      foregroundColor: secondaryColor,
                      textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600
                      )
                  ),
                  child: const Text('Skip'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Image.asset('assets/images/device2.png'),
                  ),
                  Positioned(
                      top: 310, right: 50,
                      child: Image.asset('assets/images/contact.png')),
                  Positioned(
                      top: 200, left: 30,
                      child: Image.asset('assets/images/payment.png')),
                  Container(
                    color: scaffoldColor,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
                          child: Text('The fastest transaction\nprocess only here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Text('Get easy to pay all your bills with just '
                              'a few\nsteps. Paying your bills become fast '
                              'and\nefficient.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: lightGreyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),),
                        ),
                        SmoothPageIndicator(
                          controller: controller,
                          count: 2,
                          axisDirection: Axis.horizontal,
                          onDotClicked: (i) => controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear),
                          effect: ExpandingDotsEffect(
                            expansionFactor: 3,
                            activeDotColor: mainColor,
                            spacing: 8,
                            radius: 16,
                            dotWidth: 10,
                            dotHeight: 8,
                            dotColor: const Color(0xFFE5E7EB),
                            paintStyle: PaintingStyle.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: buttonWidget(onTap: () {
                            pushScreen(context, screen: const SignInView());
                          },
                              text: 'Get Started'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}