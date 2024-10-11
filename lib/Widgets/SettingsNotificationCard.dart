import 'package:flutter/material.dart';

class Settingsnotificationcard extends StatefulWidget {
  const Settingsnotificationcard({super.key});

  @override
  State<Settingsnotificationcard> createState() => _SettingsnotificationcardState();
}

class _SettingsnotificationcardState extends State<Settingsnotificationcard> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0XFFE2EDF2),
          border: Border.all(
            color: Color(0xffA2C2D0),
          ),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.notifications_none_sharp,
              size: 30,
            ),
            SizedBox(width: 20,),
            Expanded(
                child: Text(
              "Notification",
              style: TextStyle(fontSize: 18),
            )),
            Switch(
              activeColor: Colors.white,
              activeTrackColor: Color(0XFFA2C2D0),
              inactiveThumbColor: Color(0XFF7A4D4D),
              value: light,
              onChanged: (bool value) {
                setState(() {
                  light = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
