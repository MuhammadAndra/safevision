import 'package:flutter/material.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/DailyNotificationCard.dart';
import 'package:safevision/Entities/DailyNotificationData.dart';
import 'package:safevision/Entities/NotificationData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notificationpage extends StatefulWidget {
  Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late DatabaseReference _dbRef;
  List<DailyNotificationData> _notificationData = [];
  
  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser; // Inisialisasi pengguna saat ini
    if (_user != null) {
      _dbRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(_user!.uid)
          .child('AllNotifications');

      _dbRef.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        print(data); // Debugging: cek isi data dari Firebase

        if (data != null && data is Map) {
          _notificationData = data.values
              .map((item) {
                final itemMap = item as Map<dynamic, dynamic>;
                // Ambil notificationDate dari root item
                DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(
                    itemMap['notificationDate']);

                // Proses setiap notifikasi di dalam todayNotification
                List<NotificationData> notifications = [];
                if (itemMap['todayNotification'] is Map) {
                  notifications =
                      (itemMap['todayNotification'] as Map<dynamic, dynamic>)
                          .values
                          .map((notification) {
                    final notificationMap =
                        notification as Map<dynamic, dynamic>;
                    return NotificationData(
                      suspicious: notificationMap['suspicious'],
                      cameraLocation: notificationMap['cameraLocation'],
                      alertMessage: notificationMap['alertMessage'],
                      alertTime: DateTime.fromMillisecondsSinceEpoch(
                              notificationMap['alertTime'])
                          ,
                    );
                  }).toList();
                }
                return DailyNotificationData(
                  dateTime: notificationDate,
                  notificationList: notifications,
                );
              })
              .toList()
              .cast<DailyNotificationData>();
              _notificationData.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        }

        setState(() {});
      });
    }
  }

  List<DailyNotificationData> allNotification = [
    DailyNotificationData(
      dateTime: DateTime(2024, 11, 1),
      notificationList: [
        NotificationData(
          suspicious: true,
          cameraLocation: 'Backyard',
          alertMessage: 'Suspicious motion detected',
          alertTime: DateTime(2024, 11, 1,22,30),
        ),
        NotificationData(
          suspicious: false,
          cameraLocation: 'Front Door',
          alertMessage: 'Motion detected',
          alertTime: DateTime(2024, 11, 1,9,15),
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
          alertTime: DateTime(2024, 10, 9,23,25),
        ),
        NotificationData(
          suspicious: false,
          cameraLocation: 'Backyard',
          alertMessage: 'Motion detected',
          alertTime: DateTime(2024, 10, 9,23,30),
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
          alertTime: DateTime(2024, 8, 27,10,10),
        ),
        NotificationData(
          suspicious: false,
          cameraLocation: 'Garage',
          alertMessage: 'Motion detected',
          alertTime: DateTime(2024, 8, 27,10,15),
        ),
        NotificationData(
          suspicious: true,
          cameraLocation: 'Backyard',
          alertMessage: 'Suspicious motion detected',
          alertTime: DateTime(2024, 8, 27,22,30),
        ),
      ],
    ),
    DailyNotificationData(
      dateTime: DateTime(2023, 10, 8),
      notificationList: [
        NotificationData(
          suspicious: false,
          cameraLocation: 'Living Room',
          alertMessage: 'Motion detected',
          alertTime: DateTime(2023, 10, 8,10,10),
        ),
        NotificationData(
          suspicious: false,
          cameraLocation: 'Garage',
          alertMessage: 'Motion detected',
          alertTime: DateTime(2023, 10, 8,10,15),
        ),
        NotificationData(
          suspicious: true,
          cameraLocation: 'Backyard',
          alertMessage: 'Suspicious motion detected',
          alertTime: DateTime(2023, 10, 8,22,30),
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
                for (int i = 0; i < _notificationData.length; i++)
                  DailynotificationCard(
                    dailyNotificationData: _notificationData[i],
                  ),
              ],
            ),
          ),
        ));
  }
}
