class NotificationData {
  final bool suspicious;
  final String cameraLocation;
  final String alertMessage;
  final DateTime alertTime;
  NotificationData(
      {required this.suspicious,
      required this.cameraLocation,
      required this.alertMessage,
      required this.alertTime});
}