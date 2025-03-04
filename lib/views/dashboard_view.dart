import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/controller/auth_controller.dart';
import 'package:smartpay/helpers/utility.dart';
import 'package:smartpay/model/account.dart';
import 'package:smartpay/model/secret.dart';
import 'package:smartpay/widgets/button_widget.dart';

class DashboardView extends StatefulWidget {
  final String token;
  const DashboardView({super.key, required this.token});

  @override
  DashboardViewState createState() => DashboardViewState();
}

class DashboardViewState extends StateMVC<DashboardView> {
  DashboardViewState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      con.getSecretCode(context, widget.token);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hello, Welcome to SmartPay',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text('Below is your Secret Code',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ),
              context.watch<Account>().isLoading ?
                  Utility.loader() :
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('${context.watch<Secret>().code!.secret}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                child: buttonWidget(onTap: () {
                  con.logout();
                }, text: 'logout'),
              )
            ],
          ),
      ),
    );
  }
}
