import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/OtpTextField.dart';

class Enterverification extends StatelessWidget {
  Enterverification({super.key});
  String verificationCode = ''; //ambil kodenya dari sini
  void handleCodeChange(String code) {
    verificationCode = code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0.0,
        title: const Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Verification Code",
                style: const TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please enter your new password",
                style: TextStyle(
                    color: Color(0XFF4D6D7A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(height: 30),
              Otptextfield(
                onCodeChanged: handleCodeChange,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "code was sent to your email",
                  style: TextStyle(
                    color: Color(0XFF4D6D7A),
                    fontSize: 14,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "ikramggntgbgt@gmail.com",
                  style: TextStyle(
                      color: Color(0XFF4D6D7A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50),
              Actionbutton(
                  textButton: "Verify Code",
                  onPressed: () {
                    Navigator.pushNamed(context, 'resetpassword');
                  },
                  safe: true),
              SizedBox(height: 10),
              Actionbutton(
                textButton: "Send Another Code",
                onPressed: () {},
                safe: true,
                sendVerif: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
