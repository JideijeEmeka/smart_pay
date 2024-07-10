import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/helpers/secure_storage.dart';
import 'package:smartpay/helpers/shared_prefs.dart';
import 'package:smartpay/helpers/string_extension.dart';
import 'package:smartpay/helpers/toast.dart';
import 'package:smartpay/helpers/utility.dart';
import 'package:smartpay/model/account.dart';
import 'package:smartpay/repository/auth_repository.dart';
import 'package:smartpay/views/congratulations_view.dart';
import 'package:smartpay/views/create_pin_view.dart';
import 'package:smartpay/views/dashboard_view.dart';
import 'package:smartpay/views/enter_pin_view.dart';
import 'package:smartpay/views/onboarding_view.dart';
import 'package:smartpay/views/sign_in_view.dart';
import 'package:smartpay/views/tell_us_about_yourself_view.dart';
import 'package:smartpay/views/verify_otp_view.dart';

class AuthController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> verificationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> pinFormKey = GlobalKey<FormState>();
  String verificationCodes = "";
  String pin = "";
  String code = "";
  final prefsManager = SharedPrefs();

  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  OverlayEntry? loader;
  Account account = Account();

  bool hidePassword = false;
  StreamController<ErrorAnimationType>? errorAnimationController;
  TextEditingController verificationInputController = TextEditingController();
  TextEditingController pinInputController = TextEditingController();
  FocusNode verificationCodeFocusNode = FocusNode();
  final authRepository = AuthRepository();

  void initializeToast(BuildContext context) {
    toaster = FToast();
    toaster.init(context);
  }

  void checkAuthStatus() async {
    if(await prefsManager.getToken() == kLoggedOut) {
      // Go to enter login screen
      pushScreen(scaffoldKey.currentContext!,
          screen: const SignInView());
    } else if(await prefsManager.getToken() == "null") {
      pushScreen(scaffoldKey.currentContext!,
          screen: const OnboardingView());
    } else {
      Future.wait<void>([]).then((_) {
        // Go to enter pin screen
        pushScreen(scaffoldKey.currentContext!,
            screen: const EnterPinView());
      });
    }
  }

  Future enterPin() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if(pinFormKey.currentState!.validate()) {
      if(pinInputController.text == await SecureStorage.getPin()) {
        pushScreen(scaffoldKey.currentContext!,
          screen: DashboardView(token: await prefsManager.getToken()));
      } else {
        errorAnimationController!.add(ErrorAnimationType.shake);
        showToast(scaffoldKey.currentContext!, message: 'pin incorrect');
      }
    }
  }

  Future setPin() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if(pinFormKey.currentState!.validate()) {
      loader = Utility.load(scaffoldKey.currentContext!);
      SecureStorage.setPin(pinInputController.text).then((_) {
        pushScreen(scaffoldKey.currentContext!,
            screen: const CongratulationsView());
        showToast(scaffoldKey.currentContext!, message: 'pin created successfully');
      }).whenComplete(() {
        loader!.remove();
      });
    }
  }

  void getEmailToken(String email) async {
    FocusManager.instance.primaryFocus?.unfocus();
    loader = Utility.load(scaffoldKey.currentContext!);

    if(registerFormKey.currentState!.validate()) {
      authRepository.getEmailToken(email).then((res) {
        /// Navigate to Login Page
        pushScreen(scaffoldKey.currentContext!,
            screen: VerifyOtpView(
                token: res.token!.token!,
                email: email));
        showToast(scaffoldKey.currentContext!, message: res.message);
      }).catchError((err) {
        if (err is ErrorHint) {
          showToast(scaffoldKey.currentContext!,
              message: err.value[0].toString().capitalize());
          return null;
        }
        showToast(scaffoldKey.currentContext!, message: "Something went wrong");
      }).whenComplete(() {
        loader!.remove();
      });
    }
  }

  void verifyEmailToken(String email) async {
    FocusManager.instance.primaryFocus?.unfocus();
    loader = Utility.load(scaffoldKey.currentContext!);

    authRepository.verifyEmailToken(email, verificationCodes).then((res) {
      /// Navigate to Login Page
      pushScreen(scaffoldKey.currentContext!,
          screen: TellUsAboutYourselfView(email: res.email!.email!));
      showToast(scaffoldKey.currentContext!, message: res.message);
    }).catchError((err) {
      errorAnimationController!.add(ErrorAnimationType.shake);
      FocusScope.of(scaffoldKey.currentContext!)
          .requestFocus(verificationCodeFocusNode);
    }).whenComplete(() {
      verificationInputController.clear();
      setState(() {});
      loader!.remove();
    });
  }

  void register(String email) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (registerFormKey.currentState!.validate()) {
      loader = Utility.load(scaffoldKey.currentContext!);

      authRepository.register(
        fullName: fullNameController.text,
        email: email,
        username: usernameController.text,
        country: countryController.text,
        password: passwordController.text,
      ).then((res) {
        /// Navigate to Login Page
        pushScreen(scaffoldKey.currentContext!,
            screen: const CreatePinView());
        showToast(scaffoldKey.currentContext!, message: res.message);
      }).catchError((err) {
        if (err is ErrorHint) {
          showToast(scaffoldKey.currentContext!,
              message: err.value[0].toString().capitalize());
          return null;
        }
        showToast(scaffoldKey.currentContext!, message: "Something went wrong");
      }).whenComplete(() {
        loader!.remove();
      });
    }
  }

  void login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (loginFormKey.currentState!.validate()) {
      loader = Utility.load(scaffoldKey.currentContext!);

      authRepository.login(
        email: emailController.text,
        password: passwordController.text,
      ).then((res) async {
        await prefsManager.saveToken(res.token!.token!);
        await prefsManager.setAccount(res);
        scaffoldKey.currentContext!.read<Account>().update(res);

        /// Navigate to Dashboard Page
        pushScreen(scaffoldKey.currentContext!,
            screen: DashboardView(token: res.token!.token!));
        showToast(scaffoldKey.currentContext!, message: res.message);
      }).catchError((err) {
        if (err is ErrorHint) {
          showToast(scaffoldKey.currentContext!,
              message: err.value[0].toString().capitalize());
          return null;
        }
        showToast(scaffoldKey.currentContext!, message: "Something went wrong");
      }).whenComplete(() {
        loader!.remove();
      });
    }
  }

  void getSecretCode(BuildContext context, String code) {
    context.read<Account>().setLoader(true);
    authRepository.getSecretCode(code).then((res) {
      setState(() {
        code = res;
      });
    }).whenComplete(() {
      context.read<Account>().setLoader(false);
    });
  }

  void logout() {
    loader = Utility.load(scaffoldKey.currentContext!);
    authRepository.logout().then((_) {
      prefsManager.saveToken(kLoggedOut);
      pushScreen(scaffoldKey.currentContext!, screen: const SignInView());
    }).whenComplete(() {
      loader!.remove();
    });
  }

  AuthController();
}