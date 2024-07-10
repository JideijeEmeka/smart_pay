import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/views/sign_up_view.dart';
import 'package:smartpay/widgets/back_button_widget.dart';
import 'package:smartpay/widgets/button_widget.dart';
import 'package:smartpay/widgets/text_form_field_widget.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButtonWidget(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text('Create New Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: mainColor
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 30),
                    child: Text('Please, enter a new password below different\nfrom the previous password',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: lightGreyColor
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: formField(hintText: 'Password',
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon:
                        const ImageIcon(AssetImage('assets/images/visibility_off.png'))),
                  ),Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: formField(hintText: 'Confirm Password',
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon:
                        const ImageIcon(AssetImage('assets/images/visibility_off.png'))),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: buttonWidget(onTap: () {
                pushScreen(context, screen: const SignUpView());
              },
                  text: 'Create new password'),
            )
          ],
        )
      ),
    );
  }
}
