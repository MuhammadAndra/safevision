import 'package:flutter/material.dart';

class Bottomnavigationbar extends StatelessWidget {
  void Function(int)? onDestinationSelected;
  int selectedIndex;
  Bottomnavigationbar({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
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
    );
  }
}
