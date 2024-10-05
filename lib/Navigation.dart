import 'package:flutter/material.dart';
import 'package:safevision/Screens/activity.dart';
import 'package:safevision/Screens/addperson.dart';
import 'package:safevision/Screens/archive.dart';
import 'package:safevision/Screens/home.dart';
import 'package:safevision/Screens/settings.dart';
import 'package:safevision/Widgets/AppBarTest.dart';
import 'Widgets/AppBarWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const NavigationExample(),
      routes: {
        //kalo mau nambahin service disini ya
        'service/addperson':(context) => AddPerson()
      },
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
  
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  List<Widget> pages = [
    MyHomePage(title: 'Counterapp'),
    HalamanAktivitas(),
    HalamanArchive(),
    SettingsPage(title: 'Counterapp'),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      // appBar: Appbarwidget(title: 'Hello Ikram!', subtitle: 'Good Morning!'),
      // appBar: appbartest(),
      // appBar: AppBar(
      //   title: Text("test"),
      //   backgroundColor: Colors.blue,
      // ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.access_time_filled),
            icon: Badge(child: Icon(Icons.access_time_outlined)),
            label: 'Activity',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.folder),
            icon: Icon(Icons.folder_outlined),
            label: 'Archive',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}

