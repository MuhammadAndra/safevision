import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword; // untuk menentukan apakah ini TextField untuk password
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  const Customtextfield({
    super.key,
    required this.controller, // wajib ada controller
    this.hintText = '', // hintText opsional
    this.isPassword = false, // default tidak untuk password
    this.prefixIcon, // prefixIcon opsional
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      obscureText: isPassword,  // Jika untuk password, ubah teks menjadi tersembunyi
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color:Color(0XFF4D6D7A), width: 1.0), // Warna border saat tidak fokus
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color:Color(0XFF4D6D7A), width: 3.0), // Warna border saat fokus
        ),
        suffixIcon: prefixIcon != null ? Icon(prefixIcon) : null, // tambahkan ikon jika ada
      ),
    );
  }
}
