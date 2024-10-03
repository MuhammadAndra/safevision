import 'package:flutter/material.dart';

class appbartest extends StatelessWidget implements PreferredSizeWidget {
  const appbartest({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("test"),
      backgroundColor: Colors.blue,
      toolbarHeight: 250,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(250.0);
}
