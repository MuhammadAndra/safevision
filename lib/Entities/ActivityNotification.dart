class ActivityNotification {
  String? image;
  DateTime? timestamp;

  ActivityNotification({required this.image, required this.timestamp});

  factory ActivityNotification.fromMap(Map<dynamic, dynamic> data) {
    return ActivityNotification(
      timestamp: DateTime.parse(data['Timestamp']),
      image: data['Image'],
    );
  }
}
