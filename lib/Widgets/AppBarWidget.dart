import 'package:flutter/material.dart';

class Appbarwidget extends StatelessWidget implements PreferredSizeWidget {
  const Appbarwidget({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitle != null
              ? Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, letterSpacing: 0.5),
                )
              : Text(
                  title,
                  style: const TextStyle(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(
                  fontSize: 14.5,
                  letterSpacing: 0.25,
                  color: Color.fromRGBO(127, 162, 177, 100)),
            ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Badge(child: Icon(Icons.notifications_outlined)),
        ),
        IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
