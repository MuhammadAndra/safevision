import 'package:flutter/material.dart';
import 'package:safevision/Entities/ActivityNotification.dart';
import 'package:safevision/Entities/MicrophoneSound.dart';
import 'package:safevision/Widgets/ActivityChart.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

List<String> list = <String>[
  'Last 25 days',
  'Today',
];

bool showOnlyToday = false;
final List<int> recordedCount = [0, 0];
List<ActivityNotification> _activities = [];
List<dynamic> _microphones = [];

class Statspage extends StatefulWidget {
  @override
  State<Statspage> createState() => _StatspageState();
}

class _StatspageState extends State<Statspage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final List<String> recordedName = [
    "Activity",
    "Microphone\nUsage",
  ];



  @override
  void initState() {
    _user = _auth.currentUser;
    super.initState();
    _setupFirebaseListener();
  }

  void _setupFirebaseListener() {
    DatabaseReference videoRef = _databaseReference.child('users/' + _user!.uid + '/Notification');
    DatabaseReference microphoneRef = _databaseReference.child('users/' + _user!.uid + '/Microphone');

    videoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as List<dynamic>?;
      if (data != null) {
        List<ActivityNotification> videoList = [];

        for (var videoData in data) {
          if (videoData != null) {
            videoList.add(ActivityNotification.fromMap(videoData as Map<dynamic, dynamic>));
          }
        }

        setState(() {
          _activities = videoList;
          recordedCount[0] = videoList.length;
        });
      }
    }).onError((error) {
      print('Failed to load videos: $error');
    });

    microphoneRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        List<MicrophoneSound> microphoneList = [];

        data.forEach((key, videoData) {
          if (videoData != null) {
            microphoneList.add(MicrophoneSound.fromMap(videoData as Map<dynamic, dynamic>));
          }
        });

        setState(() {
          _microphones = microphoneList;
          recordedCount[1] = microphoneList.length;
        });
      }
    }).onError((error) {
      print('Failed to load microphones: $error');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(
        title: "Statistics",
        subtitle: "New Activity Recorded",
        bold: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  DropdownMenuWidget(),
                ],
              ),
            ),
            ActivityChart(
              height: 200,
            ),
            SizedBox(
              height: 15,
            ),
            GridView.builder(
              itemCount: 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return StatsTile(
                  recordedName: recordedName[index],
                  recordedCount: recordedCount[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StatsTile extends StatelessWidget {
  final String recordedName;
  final int recordedCount;

  const StatsTile(
      {Key? key, required this.recordedName, required this.recordedCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color usedColor = Color(0xffE2EDF2);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      elevation: 0,
      color: usedColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Material(
          color: usedColor,
          elevation: 0,
          child: InkWell(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    recordedName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    recordedCount.toString(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget({super.key});

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        constraints: BoxConstraints.tight(
          Size.fromHeight(30),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
      width: 160,
      trailingIcon: Transform.translate(
        offset: Offset(3, -5),
        child: Icon(Icons.arrow_drop_down),
      ),
      initialSelection: list.first,
      onSelected: (String? value) {
        setState(() {
          if(value == "Today") {
            showOnlyToday = true;
            recordedCount[0] = 0;
            print(recordedCount);
          } else if (value == "Last 25 days") {
            showOnlyToday = false;
          }
          print(showOnlyToday);
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
