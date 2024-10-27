import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/CustomTextField.dart';

class Enteremail extends StatelessWidget {
  Enteremail({super.key});
  final TextEditingController _controllerUsername = TextEditingController();
  @override
  Size get preferredSize => const Size.fromHeight(90.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reset Password",
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            Text(
              "Please enter the email associated with your account and we'll send an verification code to reset your password.",
              style: TextStyle(
                  color: Color(0XFF4D6D7A),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(height: 30),
            Customtextfield(
              controller: _controllerUsername,
              hintText: 'Username',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            Actionbutton(
              textButton: "Send",
              onPressed: () {
                Navigator.pushNamed(context, 'enterverification');
              },
              safe: true,
            )
          ],
        ),
      ),
    );
  }
}
