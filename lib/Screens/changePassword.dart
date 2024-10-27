import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/CustomAlertDialog.dart';
import 'package:safevision/Widgets/CustomPasswordField.dart';
import 'package:safevision/Widgets/CustomTextField.dart';

class ChangepasswordPage extends StatelessWidget {
  ChangepasswordPage({super.key});
  final TextEditingController _controllerUsername = TextEditingController();
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
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbarwidget(
        title: "Change Password",
        bold: false,
        subtitle: "Change your password regularly",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please enter your new password",
              style: TextStyle(
                  color: Color(0XFF4D6D7A),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(height: 30),
            Customtextfield(
              controller: _controllerUsername,
              hintText: 'Username',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
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
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'enteremail');
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: Color(0XFF4D6D7A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
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
