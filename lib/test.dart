import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Menggunakan provider untuk state management
import 'PusherService.dart'; // Mengimpor service yang sudah kita buat

class TestHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pusher Image Example"),
      ),
      body: Center(
        child: Consumer<PusherService>(
          builder: (context, pusherService, child) {
            if (pusherService.imageData != null) {
              // Jika ada data gambar, tampilkan sebagai Image
              return Image.memory(
                base64Decode(pusherService.imageData!.replaceAll(RegExp(r'\s+'), '')), // Decode Base64 menjadi gambar
                fit: BoxFit.cover,
              );
            } else {
              return Text("Waiting for image...");
            }
          },
        ),
      ),
    );
  }
}
