import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActivityChart.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/CameraCarousel.dart';
import 'package:safevision/Widgets/ConnectedDevice.dart';
import 'package:safevision/Widgets/SectionTitle.dart';
import 'package:safevision/Widgets/Services.dart';
import 'package:safevision/Widgets/SuspiciousActivityDetected.dart';
import 'package:m3_carousel/m3_carousel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbarwidget(
            title: 'Hello Ikram!', subtitle: 'Good Morning!', bold: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                Suspiciousactivitydetected(),
                // SizedBox(height: 24),
                Sectiontitle(title: "Live Camera", seeAll: true, route: 'service/livecamera',),
                SizedBox(height: 20),
                Cameracarousel(),
                SizedBox(height: 20),
                Sectiontitle(title: "Service"),
                Services(),
                Sectiontitle(title: "Connected Devices", seeAll: true,),
                // Sectiontitle(title: "Connected Devices", seeAll: true,),
                // Sectiontitle(title: "Connected Devices", seeAll: true,),
                DeviceGrid(),
                Sectiontitle(title: "Statistics", seeAll: true,),
                ActivityChart(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
    );
  }
}
