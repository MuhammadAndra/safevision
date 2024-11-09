import 'package:flutter/material.dart';
import 'package:safevision/Screens/loginpage.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/CustomAlertDialog.dart';
import 'package:safevision/Widgets/SettingsCard.dart';
import 'package:safevision/Widgets/SettingsNotificationCard.dart';
import 'package:safevision/Widgets/UserInfoCard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "login");
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Customalertdialog(
          icon: Icons.gpp_maybe_outlined,
          safe: false,
          title: "Are you sure you want to Log Out?",
          mainAction: "Yes",
          secAction: "No",
          mainOnPressed: () {
            Navigator.of(context).pop();
            logout();
          },
          secOnPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(
        title: "Settings",
        bold: false,
        subtitle: "Customize settings to your liking",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Userinfocard(),
            SizedBox(height: 14),
            Settingsnotificationcard(),
            SizedBox(height: 14),
            Settingscard(
              icon: Icons.shopping_cart_outlined,
              menuName: "Subcription",
              onTap: () {
                Navigator.pushNamed(context, 'subcription');
              },
            ),
            SizedBox(height: 14),
            Settingscard(
              icon: Icons.password,
              menuName: "Change Password",
              onTap: () {
                Navigator.pushNamed(context, 'changepassword');
              },
            ),
            SizedBox(height: 14),
            Settingscard(
              icon: Icons.help_outline,
              menuName: "Support",
              onTap: () {
                Navigator.pushNamed(context, 'recordDetail');
              },
            ),
            SizedBox(height: 14),
            Actionbutton(
              textButton: "Log Out",
              safe: false,
              onPressed: () {
                _showCancelDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
