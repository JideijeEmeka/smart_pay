import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smartpay/controller/auth_controller.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/helpers/validation.dart';
import 'package:smartpay/repository/auth_repository.dart';
import 'package:smartpay/views/verify_otp_view.dart';
import 'package:smartpay/widgets/back_button_widget.dart';
import 'package:smartpay/widgets/button_widget.dart';
import 'package:smartpay/widgets/text_form_field_widget.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends StateMVC<SignUpView> {
  SignUpViewState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;

  @override
  void initState() {
    con.initializeToast(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Form(
            key: con.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButtonWidget(context),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 30),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Create a ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: mainColor
                          )
                        ),
                        TextSpan(text: 'Smartpay\n',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor
                            )),
                        TextSpan(text: 'account',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: mainColor
                            )),
                      ]
                    ),
                  )
                ),
                formField(hintText: 'Email',
                  textInputAction: TextInputAction.done,
                  controller: con.emailController,
                  validator: (input) {
                    if(input!.isEmpty) {
                      return 'Email is empty';
                    }else if(!isEmail(input)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: buttonWidget(
                    onTap: () {
                      con.getEmailToken(con.emailController.text);
                    },
                    text: 'Sign Up',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: const FractionalOffset(0.5, 0.0),
                              end: const FractionalOffset(0.0, 0.0),
                              stops: const [0.0, 1.0],
                              tileMode: TileMode.clamp,
                              colors: [
                                dividerColor,
                                dividerColor.withOpacity(0.1),
                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: lightGreyColor
                            )),
                      ),
                      Container(
                        width: 150,
                        height: 5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: const FractionalOffset(0.0, 0.5),
                              end: const FractionalOffset(0.0, 0.0),
                              stops: const [1.0, 0.0],
                              tileMode: TileMode.clamp,
                              colors: [
                                dividerColor,
                                dividerColor.withOpacity(0.1),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 155,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: dividerColor)
                      ),
                      child: Image.asset('assets/images/google.png'),
                    ),
                    Container(
                      height: 56,
                      width: 155,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: dividerColor)
                      ),
                      child: Image.asset('assets/images/apple.png'),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: lightGreyColor
                          )),
                      Text('Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: secondaryColor
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
