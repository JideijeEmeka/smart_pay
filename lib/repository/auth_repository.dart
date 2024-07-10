import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/model/account.dart';
import 'dart:io' show Platform;
import 'package:smartpay/model/email_token.dart';

class AuthRepository {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<EmailToken> getEmailToken(String email) async {
    var response = await http.post(Uri.parse("$kHostUrl/auth/email"),
      body: {
        "email": email,
      },
    );
    debugPrint(response.body);
    return EmailToken.fromJson(json.decode(response.body));
  }

  Future<EmailToken> verifyEmailToken(String email, String token) async {
    var response = await http.post(Uri.parse("$kHostUrl/auth/email/verify"),
      body: {
        "email": email,
        "token": token,
      },
    );
    if (response.statusCode >= kStatusBadRequest) {
      throw ErrorHint("Error trying to verify email..Check your details!");
    }
    debugPrint(response.body);
    return EmailToken.fromJson(json.decode(response.body));
  }

  Future<Account> register({
    required String fullName,
      required String email,
      required String username,
      required String country,
      required String password}) async {

    var response = await http.post(Uri.parse("$kHostUrl/auth/register"),
      body: {
        "full_name": fullName,
        "email": email,
        "username": username,
        "country": country,
        "password": password,
        "device_name": Platform.isAndroid
            ? 'android'
            : Platform.isIOS ? 'ios'
            : 'web',
      },
    );
    if (response.statusCode >= kStatusBadRequest) {
      throw ErrorHint("Error trying to register..Check your details!");
    }
    debugPrint(response.body);
    return Account.fromJson(json.decode(response.body));
  }

  Future<Account> login({
    required String email,
    required String password}) async {

    var response = await http.post(Uri.parse("$kHostUrl/auth/login"),
      body: {
        "email": email,
        "password": password,
        "device_name": Platform.isAndroid
      ? 'android'
          : Platform.isIOS ? 'ios'
          : 'web',
      },
    );
    if (response.statusCode >= kStatusBadRequest) {
      throw ErrorHint("Error trying to login..Check your details!");
    }
    debugPrint(response.body);
    return Account.fromJson(json.decode(response.body));
  }

  Future<Account> login1() async {

    var response = await http.post(Uri.parse("$kHostUrl/auth/login"),
      body: {
        "email": 'all@gmail.com',
        "password": 'Allin123!',
        "device_name": Platform.isAndroid
            ? 'android'
                : Platform.isIOS ? 'ios'
                : 'web',
      },
    );
    debugPrint(response.body);
    return Account.fromJson(json.decode(response.body));
  }

  Future getSecretCode(String code) async {
    var response = await http.get(Uri.parse("$kHostUrl/dashboard"),
        headers: {
          "Token": code,
        }
    );
    debugPrint(response.body);
  }

  Future logout() async {
    await http.post(Uri.parse("$kHostUrl/auth/logout"));
  }
}