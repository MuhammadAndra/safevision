import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Entities/ActivityNotification.dart';


class ActivityChart extends StatefulWidget {
  const ActivityChart({super.key, this.height = 150});
  final double? height;


  @override
  State<ActivityChart> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart> {
  DateTime currentDate = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  List<ActivityNotification> activities = [];
  double _maxDailyCount = 10;

  @override
  void initState() {
    _user = _auth.currentUser;
    super.initState();
    _setupVideoListener();
  }

  void _setupVideoListener() {
    DatabaseReference videoRef = _databaseReference.child('users/' + _user!.uid + '/Notification');

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
          activities = videoList;
        });
      }
    }).onError((error) {
      print('Failed to load videos: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Recorded Activity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: _maxDailyCount.toDouble(),
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Text(currentDate.subtract(Duration(days: 24)).day.toString(), style: TextStyle(fontSize: 16, color: Colors.white));
                          case 8:
                            return Text(currentDate.subtract(Duration(days: 16)).day.toString(), style: TextStyle(fontSize: 16, color: Colors.white));
                          case 16:
                            return Text(currentDate.subtract(Duration(days: 8)).day.toString(), style: TextStyle(fontSize: 16, color: Colors.white));
                          case 24:
                            return Text(currentDate.day.toString(), style: TextStyle(fontSize: 16, color: Colors.white));
                          default:
                            return Text('');
                        }
                      },
                      reservedSize: 32,
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: _getBarGroups(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    List<BarChartGroupData> createBar = [];

    for (var i = 0; i < 25; i++) {
      int _dailyActivityCount = 0;
      for (var j = 0; j < activities.length; j++) {
        if(activities[j].timestamp!.day == currentDate.subtract(Duration(days: 24-i)).day){
          _dailyActivityCount++;
          print("same day!");
        }
      }
      if(_dailyActivityCount > _maxDailyCount) {
        print("daily: " + _dailyActivityCount.toString());
        setState(() {
          _maxDailyCount = _dailyActivityCount.toDouble();
        });

        print("run");
      }
      print(_dailyActivityCount);
      createBar.add(_createBarGroup(i, _dailyActivityCount.toDouble()));
    }
    print("Max: " + _maxDailyCount.toString());

    return createBar;

  }

  BarChartGroupData _createBarGroup(int x, double toY) {
    Color barColor = (toY > 8) ? Colors.yellow : Colors.white;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: toY,
          color: barColor,
          width: 4,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
