import 'package:flutter/material.dart';
import 'package:safevision/Entities/NotifData.dart';
import 'package:safevision/Screens/detailActivity.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/SectionTitle.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HalamanAktivitas extends StatefulWidget {
  @override
  _HalamanAktivitasState createState() => _HalamanAktivitasState();
}

class _HalamanAktivitasState extends State<HalamanAktivitas> {
  DateTime _tanggalTerpilih = DateTime.now();
  DateTime _focusTanggal = DateTime.now();
  List<NotifData> _allNotifData = [];
  List<NotifData> _todayNotifData = [];

  //ngambil data record
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late DatabaseReference _dbRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _dbRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(_user!.uid)
          .child('Notification');
      _dbRef.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;

        if (data != null && data is List) {
          _allNotifData = data
              .map((item) {
                if (item is Map) {
                  String image = item['Image'] ?? 'Unknown Image';
                  DateTime date =
                      DateTime.tryParse(item['Date'] ?? '') ?? DateTime.now();
                  return NotifData(Image: image, Timestamp: date);
                }
              })
              .whereType<NotifData>()
              .toList();
        }
        _getRecordsForSelectedDate();
        setState(() {});
      });
    }
  }

  List<NotifData> _getRecordsForSelectedDate() {
    for (var notification in _allNotifData) {
      if (_tanggalTerpilih.year == notification.Timestamp.year &&
          _tanggalTerpilih.month == notification.Timestamp.month &&
          _tanggalTerpilih.day == notification.Timestamp.day) {
        _todayNotifData += [notification];
      }
    }
    return _todayNotifData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(
        title: "Activity",
        subtitle: "3 new activity today",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFFE2EDF2),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: _focusTanggal,
                    selectedDayPredicate: (day) {
                      return isSameDay(_tanggalTerpilih, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _tanggalTerpilih = selectedDay;
                        _focusTanggal = focusedDay;
                      });
                    },
                    calendarFormat: CalendarFormat.twoWeeks,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextFormatter: (date, locale) =>
                          '${date.year} - ${_formatBulan(date.month)}',
                    ),
                    daysOfWeekVisible: true,
                    availableGestures: AvailableGestures.all,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.black),
                      weekendStyle: TextStyle(color: Colors.black),
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xff4D6D7A),
                        shape: BoxShape.circle,
                      ),
                      defaultDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      weekendDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      defaultTextStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Sectiontitle(title: 'Activity List'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todayNotifData.length,
              itemBuilder: (context, index) {
                return itemAktivitas(_todayNotifData[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAktivitas(NotifData notifData, int index) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detail page when the item is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAktivitasPage(
              nama:
                  "Aktivitas ${index + 1}", 
              waktu: notifData.Timestamp.toString(),
              base64Image: notifData.Image,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Color(0XFFE2EDF2),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aktivitas ${index + 1}', // Show "Aktivitas 1", "Aktivitas 2", etc.
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(notifData.Timestamp.toString()),
                  ],
                ),
              ),
            ),
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
                image: DecorationImage(
                  image: NetworkImage(notifData.Image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatBulan(int month) {
    List<String> bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return bulan[month - 1];
  }
}
