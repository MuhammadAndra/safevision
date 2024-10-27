import 'package:flutter/material.dart';
import 'package:safevision/Navigation.dart';
import 'package:safevision/Screens/addperson.dart';
import 'package:safevision/Screens/home.dart';
import 'package:safevision/Screens/livecamera.dart';
import 'package:safevision/Screens/loginpage.dart';
import 'package:safevision/Screens/microphone.dart';
import 'package:safevision/Screens/notification.dart';
import 'package:safevision/Screens/statspage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safevision/Screens/subcription.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: NavigationExample(),
      home: Loginpage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // initialRoute: 'service/stats',
      routes: {
        //nambahin routing disini yaa
        'service/livecamera': (context) => Livecamera(),
        'service/microphone': (context) => Microphone(),
        'service/addperson': (context) => AddPerson(),
        'service/stats': (context) => Statspage(),
        'notification': (context) => Notificationpage(),
        'login': (context) => Loginpage(),
        'navigation': (context) => NavigationExample(),
        'subcription':(context)=>SubcriptionPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
