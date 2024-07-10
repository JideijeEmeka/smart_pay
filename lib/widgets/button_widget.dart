import 'package:flutter/material.dart';
import 'package:smartpay/helpers/constants.dart';

Widget buttonWidget({
  required Function() onTap,
  required String text,
  bool disabled = false,
}) {
  return GestureDetector(
    onTap: disabled ? null : onTap,
    child: Container(
      height: 56,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: disabled
              ? mainColor.withOpacity(0.5)
              : mainColor,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Center(
        child: Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white
          ),),
      ),
    ),
  );
}