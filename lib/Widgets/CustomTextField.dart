import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  const Customtextfield({
    super.key,
    required this.controller,
    this.hintText = '',
    this.isPassword = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color:Color(0XFF4D6D7A), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color:Color(0XFF4D6D7A), width: 3.0),
        ),
        suffixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
    );
  }
}
