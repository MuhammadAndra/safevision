import 'package:flutter/material.dart';
import 'package:safevision/Entities/RecordData.dart';
import 'package:safevision/Screens/recordDetail.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class HalamanArchive extends StatefulWidget {
  @override
  _HalamanArchiveState createState() => _HalamanArchiveState();
}

class _HalamanArchiveState extends State<HalamanArchive> {
  DateTime _tanggalTerpilih = DateTime.now();
  DateTime _focusTanggal = DateTime.now();
  List<RecordData> _allRecordData = [];
  List<RecordData> _todayRecordedData = [];

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
          .child('Record');
      _dbRef.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;

        if (data != null && data is List) {
          _allRecordData = data
              .map((item) {
                if (item is Map) {
                  String camera = item['Camera'] ?? 'Unknown Camera';
                  DateTime date =
                      DateTime.tryParse(item['Date'] ?? '') ?? DateTime.now();
                  String videoUrl = item['Video'] ?? '';
                  return RecordData(
                      camera: camera, date: date, videoUrl: videoUrl);
                }
              })
              .whereType<RecordData>()
              .toList();
        }
        _getRecordsForSelectedDate();
        setState(() {});
      });
    }
  }

  List<RecordData> _getRecordsForSelectedDate() {
    for (var record in _allRecordData) {
      if (_tanggalTerpilih.year == record.date.year &&
          _tanggalTerpilih.month == record.date.month &&
          _tanggalTerpilih.day == record.date.day) {
        _todayRecordedData += [record];
      }
    }
    return _todayRecordedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarwidget(
        title: "Archive",
        subtitle: "3 new archive today",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFFE2EDF2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
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
                        _todayRecordedData = [];
                        _tanggalTerpilih = selectedDay;
                        _focusTanggal = focusedDay;
                        _getRecordsForSelectedDate();
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
                    calendarStyle: const CalendarStyle(
                      todayDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Color(0XFF4D6D7A),
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
          Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Records',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (int i = 0; i < _todayRecordedData.length; i++)
                  itemArchive(_todayRecordedData[i])
                // itemArchive('Backyard - Camera', '14:15:30',
                //     'https://media.istockphoto.com/id/1330054759/photo/gift-gifting-with-family.jpg?s=612x612&w=0&k=20&c=zAmdxnDcDnmhbNGqVl30iGh0E5GcLOjk8uOiI6xxIBI='),
                // itemArchive('Front Door - Camera', '10:21:42',
                //     'https://media.istockphoto.com/id/1330054759/photo/gift-gifting-with-family.jpg?s=612x612&w=0&k=20&c=zAmdxnDcDnmhbNGqVl30iGh0E5GcLOjk8uOiI6xxIBI='),
                // itemArchive('Front Door - Camera', '09:05:20',
                //     'https://media.istockphoto.com/id/1330054759/photo/gift-gifting-with-family.jpg?s=612x612&w=0&k=20&c=zAmdxnDcDnmhbNGqVl30iGh0E5GcLOjk8uOiI6xxIBI='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemArchive(RecordData recordData) {
    String formattedTime = DateFormat('HH:mm:ss').format(recordData.date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          shadowColor: Colors.grey.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color(0XFFE2EDF2),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Recorddetail(
                    recordData: recordData,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recordData.camera,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(formattedTime),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
