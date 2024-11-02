import 'package:flutter/material.dart';
import 'package:safevision/Entities/NotificationData.dart';
import 'package:intl/intl.dart';

class Notificationcard extends StatelessWidget {
  final NotificationData notificationData;
  const Notificationcard({super.key, required this.notificationData});
  
  @override
  Widget build(BuildContext context) {
    var notificationDate =
        DateFormat('hh:mm a').format(notificationData.alertTime);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: notificationData.suspicious == true
            ? Color(0XFFF7EDED)
            : Color(0XFFEDF4F7),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: notificationData.suspicious == true
                  ? Color(0xffD0A2A2)
                  : Color(0xffA2C2D0),
            )),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.notifications_none,
                  size: 30,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notificationData.cameraLocation,
                        style:
                            TextStyle(color: Color(0XFF797979), fontSize: 12),
                      ),
                      Text(
                        notificationData.alertMessage,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      notificationDate.toString(),
                      style: TextStyle(color: Color(0XFF797979), fontSize: 12),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
