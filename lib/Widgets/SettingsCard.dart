import 'package:flutter/material.dart';

class Settingscard extends StatelessWidget {
  final IconData icon;
  final String menuName;
  final Function()? onTap;
  const Settingscard(
      {super.key,
      required this.icon,
      required this.menuName,
      required this.onTap});

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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  menuName,
                  style: TextStyle(fontSize: 18),
                )),
                Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
