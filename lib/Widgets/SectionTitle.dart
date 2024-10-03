import 'package:flutter/material.dart';

class Sectiontitle extends StatelessWidget {
  const Sectiontitle({super.key, required this.title, this.seeAll = false});
  final String title;
  final bool? seeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 14),
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
          Text(
            "See All",
            style: TextStyle(
                fontSize: 20,
                color: Colors.blueAccent
            ),
          ),
        ],
      ),
    );
  }
}
