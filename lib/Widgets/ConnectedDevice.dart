import 'package:flutter/material.dart';

class DeviceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: deviceList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
    Color usedColor = Color(0XFFE2EDF2);
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Material(
        color: usedColor,
        elevation: 0,
        child: InkWell(
          onTap: () {
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
