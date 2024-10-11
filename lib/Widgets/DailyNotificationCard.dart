import 'package:flutter/material.dart';
import 'package:safevision/Widgets/NotificationCard.dart';
import 'package:safevision/Entities/NotificationData.dart';
import 'package:safevision/Entities/DailyNotificationData.dart';
import 'package:intl/intl.dart';


class DailynotificationCard extends StatelessWidget {
  final DailyNotificationData dailyNotificationData;
  DailynotificationCard({super.key, required this.dailyNotificationData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatRelativeDate(dailyNotificationData.dateTime),
          style: TextStyle(color: Color(0XFF797979), fontSize: 16),
        ),
        for (int i = 0; i < dailyNotificationData.notificationList.length; i++)
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Notificationcard(
                  notificationData: dailyNotificationData.notificationList[i],
                ),
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
  String formatRelativeDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays == 0) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 60) {
    return '${difference.inDays ~/ 7} minggu yang lalu';
  }else {
    // Format tanggal secara lengkap jika lebih dari seminggu
    
   return 'A long time ago';
  }
}
}
