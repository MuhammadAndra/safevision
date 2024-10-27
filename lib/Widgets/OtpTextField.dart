import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otptextfield extends StatefulWidget {
  final Function(String) onCodeChanged;
  Otptextfield({super.key, required this.onCodeChanged});

  @override
  State<Otptextfield> createState() => _OtptextfieldState();
}

class _OtptextfieldState extends State<Otptextfield> {
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 5,
      borderColor: Color(0xFF4D6D7A),
      enabledBorderColor: Color(0xFFBDBDBD),
      focusedBorderColor: Color(0xFF4D6D7A),
      showFieldAsBox: true,
      borderRadius: BorderRadius.circular(10.0),
      fieldWidth: 60,
      margin: EdgeInsets.symmetric(horizontal: 5),
      textStyle: TextStyle(fontSize: 20),
      cursorColor: Color(0xFF4D6D7A),
      onSubmit: (String code) {
        widget.onCodeChanged(code);
      },
    );
  }
}
