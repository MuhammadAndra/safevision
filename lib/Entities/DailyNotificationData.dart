
import 'package:safevision/Entities/NotificationData.dart';
class DailyNotificationData {
  final DateTime dateTime;
  final List<NotificationData> notificationList;
  DailyNotificationData({required this.dateTime, required this.notificationList});
}