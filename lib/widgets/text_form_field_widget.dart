import 'package:flutter/material.dart';
import 'package:smartpay/helpers/constants.dart';

TextFormField formField({required String hintText,
  TextEditingController? controller,
  Widget? suffixIcon,
  TextInputType? keyboardType,
  bool obscureText = false,
  Function(String)? onChanged,
  Function(String)? onFieldSubmitted,
  String? Function(String?)? validator,
  bool? enabled,
  bool readOnly = false,
  TextInputAction? textInputAction}) {
  return TextFormField(
    controller: controller,
    textInputAction: textInputAction,
    keyboardType: keyboardType,
    obscureText: obscureText,
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: mainColor
    ),
    readOnly: readOnly,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    validator: validator,
    enabled: enabled,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: hintColor
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: textFormFieldColor,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(16)
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 23, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
  );
}