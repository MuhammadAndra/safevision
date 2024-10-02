import 'package:flutter/material.dart';
import 'package:safevision/Screens/activity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HalamanAktivitas(),  // Set HalamanAktivitas sebagai halaman utama
    );
  }
}
