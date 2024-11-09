import 'package:flutter/material.dart';

class Userinfocard extends StatelessWidget {
  const Userinfocard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Color(0XFFE2EDF2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Color(0xffA2C2D0),
            )),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            "Muhammad Ikram Sabila",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "ikramgtgbgt@gmail.com",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'editprofile');
                    },
                    icon: Icon(Icons.edit_outlined))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
