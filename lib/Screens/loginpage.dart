import 'package:flutter/material.dart';
import 'package:safevision/Navigation.dart';
import 'package:safevision/Screens/home.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/CustomPasswordField.dart';
import 'package:safevision/Widgets/CustomTextField.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerUsername = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment:
                  Alignment.center, // Menempatkan gambar di tengah horizontal
              child: Image(
                image: AssetImage('assets/SafeVision.png'),
                height: 100,
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Customtextfield(
              controller: _controllerUsername,
              hintText: 'Username',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            CustomPasswordField(
              controller: _controllerPassword,
              hintText: 'Password',
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4D6D7A),
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Actionbutton(
                textButton: "Sign In",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationExample()
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                red: false),
            SizedBox(
              height: 50,
            ),
            Text(
              "Trouble while signing in? contact us at SaveVision@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0XFF849EA9)),
            )
          ],
        ),
      ),
    );
  }
}
