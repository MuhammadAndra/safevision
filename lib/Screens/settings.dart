import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/SettingsCard.dart';
import 'package:safevision/Widgets/SettingsNotificationCard.dart';
import 'package:safevision/Widgets/UserInfoCard.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              onTap: (){},
            ),
            SizedBox(height: 14),
            Settingscard(
              icon: Icons.password,
              menuName: "Change Password",
              onTap: (){},
            ),
            SizedBox(height: 14),
            Settingscard(
              icon: Icons.help_outline,
              menuName: "Support",
              onTap: (){},
            ),
            SizedBox(height: 14),
            Actionbutton(
              textButton: "Log Out",
              red: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
