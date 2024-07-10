import 'package:flutter/material.dart';
import 'package:smartpay/helpers/custom_trace.dart';

class Account with ChangeNotifier {
  String? message;
  User? user;
  Token? token;

  bool isLoading = true;

  Account({
    this.message,
    this.token,
    this.user});

  Account.fromJson(Map<String, dynamic> jsonMap) {
    try {
      message = jsonMap['message'] ?? '';
      user = jsonMap['data']['user'] != null
        ? User.fromJson(jsonMap['data']['user'])
        : User.fromJson({});
      token = jsonMap['data'] != null
        ? Token.fromJson(jsonMap['data'])
        : Token.fromJson({});
    } catch (e) {
      // ignore: avoid_print
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  void update(Account a) {
    message = a.message;
    isLoading = a.isLoading;
    notifyListeners();
  }

  void setLoader(bool status) {
    isLoading = status;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user"] = user;
    data["message"] = message;
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? userName;
  String? fullName;
  String? country;

  bool isLoading = true;

  User({
    this.id,
    this.email,
    this.userName,
    this.fullName,
    this.country,});

  User.fromJson(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? '';
      email = jsonMap['email'] ?? '';
      userName = jsonMap['username'] ?? '';
      fullName = jsonMap['full_name'] ?? '';
      country = jsonMap['country'] ?? '';
    } catch (e) {
      // ignore: avoid_print
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["email"] = email;
    data["username"] = userName;
    data["full_name"] = fullName;
    data["country"] = country;
    return data;
  }
}

class Token {
  String? token;
  Token({this.token});

  Token.fromJson(Map<String, dynamic> jsonMap) {
    try {
      token = jsonMap['token'] ?? '';
    } catch (e) {
      // ignore: avoid_print
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    return data;
  }
}