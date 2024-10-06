import 'package:flutter/material.dart';
import 'package:safevision/Navigation.dart';
import 'package:safevision/Screens/activity.dart';
import 'package:safevision/Screens/addperson.dart';
import 'package:safevision/Screens/livecamera.dart';
import 'package:safevision/Screens/statspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationExample(),  
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // initialRoute: 'service/livecamera',
      routes: {
        //nambahin routing disini yaa
        'service/livecamera': (context) => Livecamera(),
        'service/addperson': (context) => AddPerson(),
        'service/stats': (context) => Statspage(),
      },
    );
  }
}