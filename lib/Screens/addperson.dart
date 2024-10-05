import 'package:flutter/material.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';


class AddPerson extends StatelessWidget {
  const AddPerson({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Appbarwidget(
        title: 'Registered Person',
        subtitle: '3 Registered',
        bold: false,
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [

            ],
          ),
        ),
    );
  }
}
