import 'package:flutter/material.dart';
import 'package:safevision/Screens/activity.dart';
import 'package:safevision/Screens/addperson.dart';
import 'package:safevision/Screens/archive.dart';
import 'package:safevision/Screens/home.dart';
import 'package:safevision/Screens/settings.dart';
import 'package:safevision/Widgets/AppBarTest.dart';
import 'package:safevision/Widgets/BottomNavigationBar.dart';
import 'Widgets/AppBarWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
// theme: ThemeData(
//   fontFamily: 'Poppins',
//   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//   useMaterial3: true,
// ),
//       home: const NavigationExample(),
//       routes: {
//         //kalo mau nambahin service disini ya
//         'service/addperson': (context) => AddPerson(),
//         'service/stats': (context) => Statspage(),
//       },
//     );
//   }
// }

class NavigationExample extends StatefulWidget {
  // final User user;
  const NavigationExample({super.key});
  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  List<Widget> pages = [
      MyHomePage( title: 'Counterapp',/* user: user,*/),
      HalamanAktivitas(),
      HalamanArchive(),
      SettingsPage(title: 'Counterapp'),
    ];
  void navigateBottomBar(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // User user = widget.user;
    
    return Scaffold(
      bottomNavigationBar: Bottomnavigationbar(
        onDestinationSelected: (index) => navigateBottomBar(index),
        selectedIndex: currentPageIndex,
      ),
      body: pages[currentPageIndex],

      // NavigationBar(
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   // indicatorColor: Colors.amber,
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home),
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.access_time_filled),
      //       icon: Badge(child: Icon(Icons.access_time_outlined)),
      //       label: 'Activity',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.folder),
      //       icon: Icon(Icons.folder_outlined),
      //       label: 'Archive',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.settings),
      //       icon: Icon(Icons.settings_outlined),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),

      // appBar: Appbarwidget(title: 'Hello Ikram!', subtitle: 'Good Morning!'),
      // appBar: appbartest(),
      // appBar: AppBar(
      //   title: Text("test"),
      //   backgroundColor: Colors.blue,
      // ),
    );
  }
}
