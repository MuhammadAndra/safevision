import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActionButton.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF4D6D7A),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            SizedBox(height: 10),
            Text(
              'Easy Way to Achieve ',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Maximum Security System',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/recolor3.png',
              fit: BoxFit.cover,
              height: 350,
              alignment: Alignment.centerRight,
            ),
            SizedBox(height: 30),
            Actionbutton(
              textButton: "Get Started",
              onPressed: () {
                Navigator.pushNamed(context, 'onboarding');
              },
              safe: true,
              sendVerif: true,
            )
          ],
        ),
      ),
    );
  }
}
