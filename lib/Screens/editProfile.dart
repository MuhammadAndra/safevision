import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/CustomAlertDialog.dart';
import 'package:safevision/Widgets/CustomTextField.dart';

class Editprofilepage extends StatelessWidget {
  Editprofilepage({super.key});
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Customalertdialog(
          icon: Icons.check_circle_outline,
          safe: true,
          title: "Profile Updated",
          subtitle: "Your profile has been updated!",
          mainAction: "Close",
          mainOnPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0.0,
        title: const Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Profile",
                style: const TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'notification');
              },
              icon: const Badge(child: Icon(Icons.notifications_outlined)),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          Color(0XFF4D6D7A),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.white,
                        iconSize:
                            18,
                        onPressed: () {
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Customtextfield(
                controller: _controllerName,
                hintText: "Enter your name",
              ),
              SizedBox(height: 10),
              Customtextfield(
                controller: _controllerEmail,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              Customtextfield(
                controller: _controllerAddress,
                hintText: "Enter your address",
              ),
              SizedBox(height: 10),
              Customtextfield(
                controller: _controllerPhoneNumber,
                hintText: "Enter your phone number",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30),
              Actionbutton(
                  textButton: "Update",
                  onPressed: () {
                    _showDialog(context);
                  },
                  safe: true)
            ],
          ),
        ),
      ),
    );
  }
}
