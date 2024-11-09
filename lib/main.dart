import 'package:flutter/material.dart';
import 'package:safevision/Navigation.dart';
import 'package:safevision/Screens/addperson.dart';
import 'package:safevision/Screens/changePassword.dart';
import 'package:safevision/Screens/editProfile.dart';
import 'package:safevision/Screens/enterEmail.dart';
import 'package:safevision/Screens/enterVerification.dart';
import 'package:safevision/Screens/livecamera.dart';
import 'package:safevision/Screens/loginpage.dart';
import 'package:safevision/Screens/microphone.dart';
import 'package:safevision/Screens/notification.dart';
import 'package:safevision/Screens/onboarding.dart';
import 'package:safevision/Screens/resetPassword.dart';
import 'package:safevision/Screens/statspage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safevision/Screens/subcription.dart';
import 'package:safevision/Screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safevision/test1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: NavigationExample(),
      home: (_auth.currentUser!=null)?  NavigationExample() : Welcomepage(),
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
        'subcription': (context) => SubcriptionPage(),
        'changepassword': (context) => ChangepasswordPage(),
        'enteremail': (context) => Enteremail(),
        'enterverification': (context) => Enterverification(),
        'resetpassword': (context) => Resetpassword(),
        'editprofile': (context) => Editprofilepage(),
        'welcome': (context) => Welcomepage(),
        'onboarding': (context) => OnboardingScreen(),
        'test1':(context)=> FirebaseImagePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
