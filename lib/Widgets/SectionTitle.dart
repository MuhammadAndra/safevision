import 'package:flutter/material.dart';

class Sectiontitle extends StatelessWidget {
  const Sectiontitle({super.key, required this.title, this.seeAll = false, this.route});
  final String title;
  final bool? seeAll;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          if (seeAll == true)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route.toString());
            },
            child: Text(
              "See All",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent
              ),
            ),
          ),
        ],
      ),
    );
  }
}
