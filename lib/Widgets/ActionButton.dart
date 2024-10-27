import 'package:flutter/material.dart';

class Actionbutton extends StatelessWidget {
  final String textButton;
  
  final void Function()? onPressed;
  final bool safe;
  const Actionbutton(
      {super.key, required this.textButton, required this.onPressed,required this.safe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Mengatur lebar button agar memenuhi layar

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
          backgroundColor: safe == true
          ? Color(0XFF4D6D7A)
          : Color(0XFF7A4D4D),
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
