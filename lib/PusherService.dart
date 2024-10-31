import 'dart:convert'; // Untuk decoding Base64
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService with ChangeNotifier {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  String? _imageData; // Variabel untuk menyimpan data gambar

  PusherService() {
    _initPusher();
  }

  // Getter untuk mengambil data gambar dari state
  String? get imageData => _imageData;

  void _initPusher() async {
    try {
      // Inisialisasi Pusher dengan callback
      await pusher.init(
        apiKey: 'c1da5e3f9f0c274c3068',
        cluster: 'ap1',
        onConnectionStateChange: _onConnectionStateChange,
        onError: _onError,
        onSubscriptionSucceeded: _onSubscriptionSucceeded,
        onEvent: _onEvent,
        onSubscriptionError: _onSubscriptionError,
        onDecryptionFailure: _onDecryptionFailure,
        onMemberAdded: _onMemberAdded,
        onMemberRemoved: _onMemberRemoved,
      );

      // Subscribe ke channel
      await pusher.subscribe(channelName: 'video-stream');
      await pusher.connect();
    } catch (e) {
      print("Error during Pusher initialization: $e");
    }
  }

  // Callback ketika menerima event
  void _onEvent(PusherEvent event) {
    print("Event received: ${event.eventName}, Data: ${event.data}");

    // Asumsi bahwa gambar dikirim sebagai string Base64 dalam event data
    final Map<String, dynamic> eventData = jsonDecode(event.data);
    if (eventData.containsKey('image')) {
      _imageData = eventData['image'];
      notifyListeners(); // Memberi tahu UI untuk diperbarui
    }
  }

  void _onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void _onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void _onSubscriptionSucceeded(String channelName, dynamic data) {
    print("Subscribed to channel: $channelName");
  }

  void _onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void _onDecryptionFailure(String event, String reason) {
    print("Decryption failed for event $event: $reason");
  }

  void _onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName member: $member");
  }

  void _onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName member: $member");
  }

  // Fungsi untuk unsubscribe dan disconnect dari Pusher
  void disconnect() {
    pusher.unsubscribe(channelName: 'presence-chatbox');
    pusher.disconnect();
  }
}
