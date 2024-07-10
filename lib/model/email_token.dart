import 'package:smartpay/helpers/custom_trace.dart';

class EmailToken {
  Token? token;
  Email? email;
  String? message;

  EmailToken.fromJson(Map<String, dynamic> jsonMap) {
    try {
      message = jsonMap['message'] ?? '';
      token = jsonMap['data'] != null
        ? Token.fromJson(jsonMap['data'])
        : Token.fromJson({});
      email = jsonMap['data'] != null
        ? Email.fromJson(jsonMap['data'])
        : Email.fromJson({});
    } catch (e) {
      // ignore: avoid_print
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["token"] = token;
    data["email"] = email;
    return data;
  }
}

class Token {
  String? token;

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

class Email {
  String? email;

  Email.fromJson(Map<String, dynamic> jsonMap) {
    try {
      email = jsonMap['email'] ?? '';
    } catch (e) {
      // ignore: avoid_print
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    return data;
  }
}