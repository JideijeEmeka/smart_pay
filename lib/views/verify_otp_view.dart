import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smartpay/controller/auth_controller.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/widgets/back_button_widget.dart';
import 'package:smartpay/widgets/button_widget.dart';

class VerifyOtpView extends StatefulWidget {
  final String email;
  final String token;
  const VerifyOtpView({super.key,
    required this.token, required this.email});

  @override
  VerifyOtpViewState createState() => VerifyOtpViewState();
}

class VerifyOtpViewState extends StateMVC<VerifyOtpView> {
  VerifyOtpViewState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;
  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    con.initializeToast(context);
    startTimer();
    con.errorAnimationController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    con.errorAnimationController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  backButtonWidget(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text('Verify it’s you ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: mainColor
                        )),
                  ),
                  Text('We send a code to ( ${widget.email} ). '
                      'Enter it here to verify your identity ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: lightGreyColor
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    child: Form(
                      key: con.verificationFormKey,
                      child: Container(
                        margin:
                        const EdgeInsets.only(left: 25,
                            right: 25, top: 50, bottom: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 5,
                          enablePinAutofill: false,
                          errorTextSpace: 24,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Invalid verification code";
                            }
                            return null;
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldWidth: 70,
                            fieldHeight: 70,
                            borderRadius: BorderRadius.circular(16),
                            selectedColor: mainColor.withOpacity(0.6),
                            activeColor: secondaryColor,
                            inactiveColor: textFormFieldColor,
                            activeFillColor: textFormFieldColor,
                            selectedFillColor: textFormFieldColor,
                            borderWidth: 20,
                            inactiveFillColor: lightGreyColor.withOpacity(0.2),
                          ),
                          cursorColor: mainColor,
                          animationDuration: const Duration(milliseconds: 300),
                          textStyle: const TextStyle(fontSize: 20, height: 1.6),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          errorAnimationController: con.errorAnimationController,
                          controller: con.verificationInputController,
                          focusNode: con.verificationCodeFocusNode,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.black12,
                              blurRadius: 50,
                            ),
                          ],
                          blinkWhenObscuring: true,
                          animationType: AnimationType.slide,
                          onCompleted: (v) {
                            //con.verifyEmailToken(widget.email);
                          },
                          onChanged: (value) {
                            setState(() {
                              con.verificationCodes = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text('Resend Code $_start secs',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: lightGreyColor
                          )),
                    ),
                  ),
                  buttonWidget(
                    onTap: () {
                      con.verifyEmailToken(widget.email);
                    },
                    text: 'Confirm',
                  ),
                ],
              ),
          ),
        )
    );
  }
}
