import 'package:flutter/material.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/DailyNotificationCard.dart';
import 'package:safevision/Entities/DailyNotificationData.dart';
import 'package:safevision/Entities/NotificationData.dart';


class Notificationpage extends StatelessWidget {
  Notificationpage({super.key});
  List<DailyNotificationData> allNotification = [
  DailyNotificationData(
    dateTime: DateTime(2024, 10, 10),
    notificationList: [
      NotificationData(
        suspicious: true,
        cameraLocation: 'Backyard',
        alertMessage: 'Suspicious motion detected',
        alertTime: '10:30 PM',
      ),
      NotificationData(
        suspicious: false,
        cameraLocation: 'Front Door',
        alertMessage: 'Motion detected',
        alertTime: '09:15 AM',
      ),
    ],
  ),
  DailyNotificationData(
    dateTime: DateTime(2024, 10, 9),
    notificationList: [
      NotificationData(
        suspicious: true,
        cameraLocation: 'Garage',
        alertMessage: 'Suspicious activity detected',
        alertTime: '11:25 PM',
      ),
      NotificationData(
        suspicious: false,
        cameraLocation: 'Backyard',
        alertMessage: 'Motion detected',
        alertTime: '11:30 PM',
      ),
    ],
  ),
  DailyNotificationData(
    dateTime: DateTime(2024, 8, 27),
    notificationList: [
      NotificationData(
        suspicious: false,
        cameraLocation: 'Living Room',
        alertMessage: 'Motion detected',
        alertTime: '10:10 AM',
      ),
      NotificationData(
        suspicious: false,
        cameraLocation: 'Garage',
        alertMessage: 'Motion detected',
        alertTime: '10:15 AM',
      ),
      NotificationData(
        suspicious: true,
        cameraLocation: 'Backyard',
        alertMessage: 'Suspicious motion detected',
        alertTime: '10:30 PM',
      ),
      
    ],
  ),DailyNotificationData(
    dateTime: DateTime(2023, 10, 8),
    notificationList: [
      NotificationData(
        suspicious: false,
        cameraLocation: 'Living Room',
        alertMessage: 'Motion detected',
        alertTime: '10:10 AM',
      ),
      NotificationData(
        suspicious: false,
        cameraLocation: 'Garage',
        alertMessage: 'Motion detected',
        alertTime: '10:15 AM',
      ),
      NotificationData(
        suspicious: true,
        cameraLocation: 'Backyard',
        alertMessage: 'Suspicious motion detected',
        alertTime: '10:30 PM',
      ),
      
    ],
  ),
  
  // Tambahkan lebih banyak data sesuai kebutuhan
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbarwidget(
          title: "Notification",
          subtitle: "There's no unreaded notification",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < allNotification.length; i++)
                  DailynotificationCard(
                    dailyNotificationData: allNotification[i],
                  ),
              ],
            ),
          ),
        ));
  }
}
