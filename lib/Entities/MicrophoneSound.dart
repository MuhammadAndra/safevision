class MicrophoneSound {
  String? sound;
  String? timestamp;

  MicrophoneSound({required this.sound, required this.timestamp});

  factory MicrophoneSound.fromMap(Map<dynamic, dynamic> data) {
    return MicrophoneSound(
      timestamp: data['timestamp'],
      sound: data['sound'],
    );
  }
}