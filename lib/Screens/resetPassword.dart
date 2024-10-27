import 'package:flutter/material.dart';
import 'package:safevision/Screens/loginpage.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/CustomAlertDialog.dart';
import 'package:safevision/Widgets/CustomPasswordField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Resetpassword extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Resetpassword({super.key});
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordConfirmation =
      TextEditingController();
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Customalertdialog(
          icon: Icons.check_circle_outline,
          safe: true,
          title: "Password Updated",
          subtitle: "Your password has been updated!",
          mainAction: "Close",
          mainOnPressed: () {
            Navigator.of(context).pop();
            if (_auth.currentUser != null) {
              // Jika pengguna aktif, arahkan langsung ke halaman utama
              Navigator.pushNamed(context, 'navigation');
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Loginpage()),
                (Route<dynamic> route) => false,
              );
            }
          },
        );
      },
    );
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
            CustomPasswordField(
              controller: _controllerPassword,
              hintText: 'Password',
            ),
            SizedBox(height: 10),
            CustomPasswordField(
              controller: _controllerPasswordConfirmation,
              hintText: 'Confirmation Password',
            ),
            SizedBox(height: 10),
            const Text(
              "Password contain at least 8 character with number and capital letter.",
              style: TextStyle(
                color: Color(0XFF4D6D7A),
                fontSize: 12,
              ),
            ),
            SizedBox(height: 30),
            Actionbutton(
                textButton: "Save",
                onPressed: () {
                  _showDialog(context);
                },
                safe: true)
          ],
        ),
      ),
    );
  }
}
