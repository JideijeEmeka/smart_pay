import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/views/verify_identity_password_reset_view.dart';
import 'package:smartpay/widgets/button_widget.dart';
import 'package:smartpay/widgets/text_form_field_widget.dart';

class PasswordRecoveryView extends StatefulWidget {
  const PasswordRecoveryView({super.key});

  @override
  State<PasswordRecoveryView> createState() => _PasswordRecoveryViewState();
}

class _PasswordRecoveryViewState extends State<PasswordRecoveryView> {
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
                Image.asset('assets/images/pass_reset_page_icon.png'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text('Password Recovery ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: mainColor
                      )),
                ),
                Text('Enter your registered email below to receive\npassword instructions ',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: lightGreyColor
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 80),
                  child: formField(hintText: 'Email'),
                ),
              ],
            ),
            buttonWidget(
              onTap: () {
                pushScreen(context, screen: const VerifyIdentityPasswordResetView());
              },
              text: 'Send me email',
            ),
          ],
        )
      )
    );
  }
}
