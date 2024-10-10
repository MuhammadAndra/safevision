import 'package:flutter/material.dart';

class Personcard extends StatelessWidget {
  final String imageUrl;

  final String personName;
  final String relationship;

  const Personcard(
      {super.key,
      required this.imageUrl,
      required this.personName,
      required this.relationship});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 260,
      decoration: BoxDecoration(
        color: Color(0XFFE2EDF2),
        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 175,
            height: 175,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // width: 115,
                    child: Flexible(
                      child: Text(
                        personName,
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              relationship,
              style: TextStyle(fontSize: 15, color: Color(0XFF49454F)),
            ),
          ),
        ],
      ),
    );
  }
}
