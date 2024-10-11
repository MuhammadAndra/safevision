import 'package:flutter/material.dart';

class Userinfocard extends StatelessWidget {
  const Userinfocard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFE2EDF2),
        border: Border.all(
          color: Color(0xffA2C2D0),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 225,
                  child: Text(
                    "Muhammad Ikram Sabila",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "ikramgtgbgt@gmail.com",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined))
          ],
        ),
      ),
    );
  }
}
