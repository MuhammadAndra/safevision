import 'package:flutter/material.dart';

class Customalertdialog extends StatelessWidget {
  final IconData icon;
  final bool safe;
  final String title;
  final String? subtitle;
  final String mainAction;
  final String? secAction;
  final Function()? mainOnPressed;
  final Function()? secOnPressed;
  const Customalertdialog(
      {super.key,
      required this.icon,
      required this.safe,
      required this.title,
      this.subtitle,
      required this.mainAction,
      this.secAction,
      required this.mainOnPressed,
      this.secOnPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: safe == true ? Color(0XFFE2EDF2) : Color(0XFFF2E2E2),
      icon: Icon(
        icon,
        color: safe == true ? Color(0XFF4D6D7A) : Color(0XFF7A4D4D),
        size: 80,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: safe == true ? Color(0XFF4D6D7A) : Color(0XFF7A4D4D),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: subtitle != null
          ? Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: safe == true ? Color(0XFF4D6D7A) : Color(0XFF7A4D4D)),
            )
          : null,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        if (secAction != null)
          TextButton(
            onPressed: secOnPressed,
            child: Text(secAction!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: safe == true ? Color(0XFF7A4D4D) : Color(0XFF4D6D7A),
                )),
          ),
        TextButton(
          onPressed: mainOnPressed,
          child: Text(mainAction,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: safe == true ? Color(0XFF4D6D7A) : Color(0XFF7A4D4D),
              )),
        ),
      ],
    );
  }
}
