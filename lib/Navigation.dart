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

class NavigationExample extends StatefulWidget {
  // final User user;
  final int initialPageIndex;

  const NavigationExample({super.key, this.initialPageIndex = 0});
  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialPageIndex;
  }

  List<Widget> pages = [
    MyHomePage(
      title: 'Counterapp', /* user: user,*/
    ),
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
    );
  }
}
