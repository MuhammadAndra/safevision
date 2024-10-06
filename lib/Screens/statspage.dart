import 'package:flutter/material.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
class Statspage extends StatelessWidget {
  const Statspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(title: "Statistics",subtitle: "New Activity Recorded",bold: false,),
    );
  }
}