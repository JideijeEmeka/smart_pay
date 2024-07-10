import 'package:flutter/cupertino.dart';
import 'package:smartpay/helpers/custom_trace.dart';

class Secret with ChangeNotifier {
  String? message;
  Code? code;
  Secret({this.message});

  Secret.fromJson(Map<String, dynamic> jsonMap) {
    try {
      message = jsonMap['message'] ?? '';
      code = jsonMap['data'] != null
          ? Code.fromJson(jsonMap['data'])
          : Code.fromJson({});
    } catch (e) {
      // ignore: avoid_print
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  void update(Code c) {
    code = c;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["data"] = code;
    return data;
  }
}

class Code {
  String? secret;
  Code({this.secret});

  Code.fromJson(Map<String, dynamic> jsonMap) {
    try {
      secret = jsonMap['secret'] ?? '';
    } catch (e) {
      // ignore: avoid_print
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["secret"] = secret;
    return data;
  }
}