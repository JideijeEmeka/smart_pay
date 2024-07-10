import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/controller/auth_controller.dart';
import 'package:smartpay/helpers/utility.dart';
import 'package:smartpay/model/account.dart';
import 'package:smartpay/repository/auth_repository.dart';
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
  AuthRepository authRepository = AuthRepository();

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
                  fontSize: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text('Below is your Secret Code',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              context.watch<Account>().isLoading ?
                  Utility.loader() :
              Text('Code: ${con.code}'),
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
