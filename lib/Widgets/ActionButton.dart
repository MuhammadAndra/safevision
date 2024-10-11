import 'package:flutter/material.dart';

class Actionbutton extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  final bool red;
  const Actionbutton(
      {super.key, required this.textButton, required this.onPressed,required this.red});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Mengatur lebar button agar memenuhi layar

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
          backgroundColor: red == true
          ? Color(0XFF7A4D4D)
          : Color(0XFF4D6D7A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Membuat sudut melengkung
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: onPressed,
        child: Text(
          textButton,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
