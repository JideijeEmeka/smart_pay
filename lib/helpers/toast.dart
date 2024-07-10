import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

late FToast toaster;

void showToast(BuildContext context,
    {message = "Operation was successful",
      duration = const Duration(seconds: 2)}) {
  Fluttertoast.cancel();

  toaster.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color(0xFF000000),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
      ),
      toastDuration: duration,
      gravity: ToastGravity.BOTTOM,
      positionedToastBuilder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 120.0,
          child: child,
        );
      });
}
