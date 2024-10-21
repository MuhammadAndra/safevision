import 'package:flutter/material.dart';
import 'package:safevision/Navigation.dart';
import 'package:safevision/Screens/home.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/CustomPasswordField.dart';
import 'package:safevision/Widgets/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _errorMessage;

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<void> _loginUser() async {
    if (_controllerUsername.text.isEmpty || _controllerPassword.text.isEmpty) {
      setState(() {
        _errorMessage =
            "Email or password fields cannot be empty."; // Masukkan ke dalam setState
      });
    } else
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _controllerUsername.text,
          password: _controllerPassword.text,
        );
        setState(() {
          _user = userCredential.user;
          _errorMessage = null;
        });
        print("User logged in: ${_user!.email}");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationExample()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        print("Error logging in: $e");
        setState(() {
          _errorMessage =
              "The email or password you entered is incorrect."; // Masukkan ke dalam setState
        });
      }
  }

  @override
  Widget build(BuildContext context) {
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
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(
                    color: Colors.red), // Teks berwarna merah untuk error
              ),
            SizedBox(height: 10),
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
                  _loginUser();
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
