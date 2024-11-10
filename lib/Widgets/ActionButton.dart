import 'package:flutter/material.dart';

class Actionbutton extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  final bool safe;
  final bool? sendVerif;

  Actionbutton({
    super.key,
    required this.textButton,
    required this.onPressed,
    required this.safe,
    this.sendVerif,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: sendVerif == true 
              ? Colors.white 
              : (safe == true ? Color(0XFF4D6D7A) : Color(0XFF7A4D4D)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: sendVerif == true 
                ? BorderSide(color: Color(0XFF4D6D7A), width: 2)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: onPressed,
        child: Text(
          textButton,
          style: TextStyle(
            color: sendVerif == true ? Color(0XFF4D6D7A) : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
