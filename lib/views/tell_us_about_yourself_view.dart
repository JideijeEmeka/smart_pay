import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smartpay/controller/auth_controller.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/helpers/validation.dart';
import 'package:smartpay/widgets/back_button_widget.dart';
import 'package:smartpay/widgets/button_widget.dart';
import 'package:smartpay/widgets/text_form_field_widget.dart';

class TellUsAboutYourselfView extends StatefulWidget {
  final String email;
  const TellUsAboutYourselfView({super.key, required this.email});

  @override
  TellUsAboutYourselfViewState createState() => TellUsAboutYourselfViewState();
}

class TellUsAboutYourselfViewState extends StateMVC<TellUsAboutYourselfView> {
  TellUsAboutYourselfViewState() : super(AuthController()) {
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
                            TextSpan(text: 'Hey there! tell us a bit\nabout ',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: mainColor
                                )
                            ),
                            TextSpan(text: 'yourself',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor
                            )),
                          ]
                      ),
                    )
                ),
                formField(hintText: 'Full name',
                    textInputAction: TextInputAction.done,
                    controller: con.fullNameController,
                  validator: (input) {
                    if(input!.isEmpty) {
                      return 'Full name is empty';
                    }
                    return null;
                  }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: formField(hintText: 'Username',
                      textInputAction: TextInputAction.done,
                      controller: con.usernameController,
                      validator: (input) {
                        if(input!.isEmpty) {
                          return 'User name is empty';
                        }
                        return null;
                      }
                  ),
                ),
                formField(hintText: 'Select Country',
                    textInputAction: TextInputAction.done,
                    controller: con.countryController,
                    readOnly: true,
                    validator: (input) {
                      if(input!.isEmpty) {
                        return 'Country is empty';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        chooseCountry();
                    },
                      child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30,))
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 20),
                  child: formField(hintText: 'Password',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      controller: con.passwordController,
                      obscureText: con.hidePassword,
                      validator: (input) {
                        if(input!.isEmpty) {
                          return 'Password is empty';
                        } else if(!isPassword(input)) {
                          return 'The password must contain at least one uppercase\n'
                              'and one lowercase letter, and at least one number';
                        }
                        return null;
                      },
                      suffixIcon:
                      GestureDetector(
                          onTap: () => setState(() {
                            con.hidePassword = !con.hidePassword;
                          }),
                      child: const ImageIcon(AssetImage('assets/images/visibility_off.png')))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: buttonWidget(
                    onTap: () {
                      con.register(widget.email);
                    },
                    text: 'Continue',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseCountry() {
    return showCountryPicker(
      context: context,
      favorite: <String>['NG'],
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          con.countryController.text = country.countryCode;
        });
      },
      moveAlongWithKeyboard: false,
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        inputDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: hintColor
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor),
              borderRadius: BorderRadius.circular(16)
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
          filled: true,
          fillColor: textFormFieldColor,
          prefixIcon: Image.asset('assets/images/search.png'),
          suffixIcon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cancel',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: mainColor
                  )),
            ),
          ),
        ),
        bottomSheetHeight: 700,
        searchTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: mainColor
        ),
      ),
    );
  }
}
