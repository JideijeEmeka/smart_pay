import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smartpay/controller/auth_controller.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/widgets/button_widget.dart';

class EnterPinView extends StatefulWidget {
  const EnterPinView({super.key});

  @override
  EnterPinViewState createState() => EnterPinViewState();
}

class EnterPinViewState extends StateMVC<EnterPinView> {
  EnterPinViewState() : super(AuthController()) {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text('Enter your PIN code ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: mainColor
                    )),
              ),
              Text('We use state-of-the-art security measures '
                  'to protect your information at all times ',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: lightGreyColor
                  )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                child: Form(
                  key: con.pinFormKey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 25,
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
                          return "Pin is empty";
                        } else if(v.length < 5) {
                          return "Invalid pin";
                        }
                        return null;
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        fieldWidth: 70,
                        fieldHeight: 70,
                        borderRadius: BorderRadius.circular(16),
                        selectedColor: mainColor.withOpacity(0.6),
                        activeColor: secondaryColor,
                        inactiveColor: textFormFieldColor,
                        activeFillColor: textFormFieldColor,
                        selectedFillColor: textFormFieldColor,
                        borderWidth: 0.85,
                        inactiveFillColor: lightGreyColor.withOpacity(0.2),
                      ),
                      cursorColor: mainColor,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: const TextStyle(fontSize: 20, height: 1.6),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      obscureText: true,
                      errorAnimationController: con.errorAnimationController,
                      controller: con.pinInputController,
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
                      onCompleted: (v) {},
                      onChanged: (value) {
                        setState(() {
                          con.pin = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              buttonWidget(
                onTap: () {
                  con.enterPin();
                },
                disabled: con.pinInputController.text.isEmpty,
                text: 'Enter PIN',
              ),
            ],
          ),
        )
    );
  }
}
