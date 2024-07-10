import 'package:flutter/material.dart';
import 'package:smartpay/helpers/constants.dart';

Widget backButtonWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Icon(Icons.arrow_back_ios_new_outlined,
          color: mainColor),
    ),
  );
}