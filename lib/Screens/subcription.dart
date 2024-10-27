import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActionButton.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/CustomAlertDialog.dart';

class SubcriptionPage extends StatefulWidget {
  const SubcriptionPage({super.key});

  @override
  State<SubcriptionPage> createState() => _SubcriptionPageState();
}

class _SubcriptionPageState extends State<SubcriptionPage> {
  bool safe = true;

  void toggleSafe() {
    setState(() {
      safe = !safe; // Mengubah nilai safe
    });
  }

  void _showCancelDialogConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Customalertdialog(
          icon: Icons.gpp_maybe_outlined,
          safe: !safe,
          title: safe == true
              ? "Your subcription has been canceled"
              : "Your subcription has been added",
          mainAction: "Close",
          mainOnPressed: () {
            Navigator.of(context).pop();
            toggleSafe();
          },
        );
      },
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Customalertdialog(
          icon: Icons.gpp_maybe_outlined,
          safe: !safe,
          title: safe == true
              ? "Are you sure you want to cancel your subscription?"
              : "Subscribe to SafeVision?",
          subtitle: safe != true 
              ? "Subscribe to achive maximum security"
              : null,
          mainAction: "Yes",
          secAction: "No",
          mainOnPressed: () {
            Navigator.of(context).pop();
            _showCancelDialogConfirmation(context);
          },
          secOnPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(
        title: "Settings",
        bold: false,
        subtitle: "Extends your maximal security",
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/safevisiontitle.png',
              fit: BoxFit.cover,
              height: 35,
              alignment: Alignment.centerRight,
            ),
            SizedBox(height: 10),
            Text(
              "Secure your home with 24/7 remote monitoring and realtime notification directly to your mobile devices",
              style: TextStyle(color: Color(0XFF4D6D7A)),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                IconText(
                  text:
                      "Remote monitoring directly connected to your mobile devices",
                ),
                SizedBox(height: 10),
                IconText(
                  text:
                      "Remote monitoring directly connected to your mobile devices",
                ),
                SizedBox(height: 10),
                IconText(
                  text:
                      "Remote monitoring directly connected to your mobile devices",
                ),
                SizedBox(height: 10),
                IconText(
                  text:
                      "Remote monitoring directly connected to your mobile devices",
                ),
              ],
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center, // Memusatkan teks di tengah
              child: Text(
                "Auto-renewal is \$50/month until cancelled",
                style: TextStyle(color: Color(0XFF4D6D7A)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Actionbutton(
                textButton: "Cancel Subcrption",
                onPressed: () {
                  _showCancelDialog(context);
                },
                safe: !safe)
          ],
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final String text;
  const IconText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: Color(0XFF4D6D7A),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Color(0XFF4D6D7A)),
          ),
        ),
      ],
    );
  }
}
