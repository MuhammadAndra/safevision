import 'package:flutter/material.dart';

class Settingsnotificationcard extends StatefulWidget {
  const Settingsnotificationcard({super.key});

  @override
  State<Settingsnotificationcard> createState() =>
      _SettingsnotificationcardState();
}

class _SettingsnotificationcardState extends State<Settingsnotificationcard> {
  bool light = true;
  onChange(bool value) {
    setState(() {
      light = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Color(0XFFE2EDF2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Color(0xffA2C2D0),
            )),
        child: InkWell(
          onTap: () {
            onChange(!light);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications_none_sharp,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
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
                  onChanged: onChange,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
