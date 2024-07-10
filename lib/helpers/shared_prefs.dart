import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/model/account.dart';

class SharedPrefs {
  final Future<SharedPreferences> prefsManager = SharedPreferences.getInstance();
  late SharedPreferences prefs;

  Future<String> getToken() async {
    final prefs = await prefsManager;
    return prefs.get(kToken).toString();
  }

  Future saveToken(String token) async {
    final prefs = await prefsManager;
    return prefs.setString(kToken, token);
  }

  Future deleteToken() async {
    final prefs = await prefsManager;
    return prefs.remove(kToken);
  }

  Future setAccount(Account account) async {
    final prefs = await prefsManager;
    return prefs.setString(kAccount, json.encode(account.toJson()));
  }

  Future<Account> getAccount() async {
    final prefs = await prefsManager;
    if (prefs.containsKey(kAccount)) {
      return Account.fromJson(
          await json.decode(prefs.get(kAccount).toString()));
    }
    return Account();
  }
}