import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/views/create_new_password_view.dart';
import 'package:smartpay/widgets/button_widget.dart';

class VerifyIdentityPasswordResetView extends StatefulWidget {
  const VerifyIdentityPasswordResetView({super.key});

  @override
  State<VerifyIdentityPasswordResetView> createState() => _VerifyIdentityPasswordResetViewState();
}

class _VerifyIdentityPasswordResetViewState extends State<VerifyIdentityPasswordResetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/verify_identity.png'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text('Verify your identity ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: mainColor
                          )),
                    ),
                    Text('Where would you like Smartpay to send your\nsecurity code? ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: lightGreyColor
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: lightGreyColor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 13,
                                backgroundColor: Color(0xFF0A6375),
                                foregroundColor: Colors.white,
                                child: Icon(Icons.check, size: 15,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: mainColor
                                        )),
                                    Text('A*******@mail.com ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: lightGreyColor
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.email_outlined, color: hintColor,)
                        ],
                      ),
                    )
                  ],
                ),
                buttonWidget(
                  onTap: () {
                    pushScreen(context, screen: const CreateNewPasswordView());
                  },
                  text: 'Continue',
                ),
              ],
            )
        )
    );
  }
}
