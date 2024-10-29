import 'package:flutter/material.dart';
import 'package:safevision/Entities/Camera.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/ConnectedDevice.dart';

class Connecteddevicepage extends StatelessWidget {
  const Connecteddevicepage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Appbarwidget(
        title: 'Connected Device',
        subtitle: '4 Devices connected',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: DeviceGrid()
        ),
      ),
    );
  }
}
