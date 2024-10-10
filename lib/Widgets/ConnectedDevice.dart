import 'package:flutter/material.dart';

class DeviceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: deviceList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5, // Adjust the size of each tile
      ),
      shrinkWrap: true, // Allows GridView to fit the height of its content
      physics: NeverScrollableScrollPhysics(), // Disables GridView scrolling
      itemBuilder: (BuildContext context, int index) {
        return DeviceTile(device: deviceList[index]);
      },
    );
  }
}

class Device {
  final IconData icon;
  final String title;
  final String subtitle;

  Device({required this.icon, required this.title, required this.subtitle});
}

final List<Device> deviceList = [
  Device(icon: Icons.videocam_outlined, title: 'CAM1-BACK', subtitle: 'Camera'),
  Device(icon: Icons.videocam_outlined, title: 'CAM2-DOOR', subtitle: 'Camera'),
  Device(icon: Icons.videocam_outlined, title: 'CAM3-DINE', subtitle: 'Camera'),
  Device(icon: Icons.mic_none, title: 'MIC1-FRONT', subtitle: 'Microphone'),
];

class DeviceTile extends StatelessWidget {
  final Device device;

  const DeviceTile({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color usedColor = Theme.of(context).colorScheme.surfaceContainerHigh;
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Material(
        color: usedColor,
        elevation: 0,
        child: InkWell(
          onTap: () {
            // Handle tap action
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  device.icon,
                  size: 30,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  device.title,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  device.subtitle,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
