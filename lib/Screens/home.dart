import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActivityChart.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/CameraCarousel.dart';
import 'package:safevision/Widgets/ConnectedDevice.dart';
import 'package:safevision/Widgets/SectionTitle.dart';
import 'package:safevision/Widgets/Services.dart';
import 'package:safevision/Widgets/SuspiciousActivityDetected.dart';
import 'package:m3_carousel/m3_carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // final User user; 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  User? _user;
  int _counter = 0;
  String userEmail = '';
  String username = '';

  @override
  void initState() {
    _user = _auth.currentUser;
    super.initState();
    fetchName();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void fetchName()async {
    DatabaseReference nameRef = _databaseReference.child('users/' + _user!.uid + '/name');
    DataSnapshot snapshot = await nameRef.get();
    if(snapshot.exists) {
      setState(() {
        username = snapshot.value as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? userFirebase = FirebaseAuth.instance.currentUser;


    if (userFirebase!=null) {
      setState(() {
        userEmail = userFirebase!.email.toString();

      });
    }
    return Scaffold(
      appBar: Appbarwidget(
          title: "Hello $username", subtitle: 'Good Morning!', bold: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Suspiciousactivitydetected(),
              // SizedBox(height: 24),
              Sectiontitle(
                title: "Live Camera",
                seeAll: true,
                route: 'service/livecamera',
              ),
              SizedBox(height: 20),
              Cameracarousel(),
              // SizedBox(height: 20),
              Sectiontitle(title: "Service"),
              Services(),
              Sectiontitle(
                title: "Connected Devices",
                seeAll: true,
                route: 'test1',
              ),
              // Sectiontitle(title: "Connected Devices", seeAll: true,),
              // Sectiontitle(title: "Connected Devices", seeAll: true,),
              DeviceGrid(),
              Sectiontitle(
                  title: "Statistics", seeAll: true, route: 'service/stats'),
              ActivityChart(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
