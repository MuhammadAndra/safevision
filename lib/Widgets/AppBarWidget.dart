import 'package:flutter/material.dart';

class Appbarwidget extends StatelessWidget implements PreferredSizeWidget {
  const Appbarwidget({super.key, required this.title, this.subtitle, this.bold = false});

  final String title;
  final String? subtitle;
  final bool? bold;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 400,
      // backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bold == true
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
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Badge(child: Icon(Icons.notifications_outlined)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/profile.jpg'),
              
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90.0);
}