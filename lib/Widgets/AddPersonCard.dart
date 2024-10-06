import 'package:flutter/material.dart';

class AddPersonCard extends StatelessWidget {
  void Function()? onPressed;
  AddPersonCard({super.key,required this.onPressed});

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
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFE2EDF2),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 100,
                  color: Color(0XFF234D5F),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Container(
              height: 40,
              child: const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Add new ",
                  style: TextStyle(fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
