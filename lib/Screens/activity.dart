import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HalamanAktivitas extends StatefulWidget {
  @override
  _HalamanAktivitasState createState() => _HalamanAktivitasState();
}

class _HalamanAktivitasState extends State<HalamanAktivitas> {
  DateTime _tanggalTerpilih = DateTime.now();
  DateTime _focusTanggal = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Aktivitas'),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://via.placeholder.com/150',
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Aktivitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Arsip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100], 
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
                        color: Colors.blue[400], 
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
              'Activity List',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                itemAktivitas('Orang Ketiga', '14:15:30', 'https://media.istockphoto.com/id/1330054759/photo/gift-gifting-with-family.jpg?s=612x612&w=0&k=20&c=zAmdxnDcDnmhbNGqVl30iGh0E5GcLOjk8uOiI6xxIBI='),
                itemAktivitas('Orang Kedua', '10:21:42', 'https://media.istockphoto.com/id/1330054759/photo/gift-gifting-with-family.jpg?s=612x612&w=0&k=20&c=zAmdxnDcDnmhbNGqVl30iGh0E5GcLOjk8uOiI6xxIBI='),
                itemAktivitas('Orang Pertama', '09:05:20', 'https://media.istockphoto.com/id/1330054759/photo/gift-gifting-with-family.jpg?s=612x612&w=0&k=20&c=zAmdxnDcDnmhbNGqVl30iGh0E5GcLOjk8uOiI6xxIBI='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAktivitas(String nama, String waktu, String urlGambar) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), 
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80, 
            height: 80, 
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), 
              bottomLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(urlGambar),
                fit: BoxFit.cover, 
              ),
            ),
          ),
          SizedBox(width: 16), 
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(waktu),
              ],
            ),
          ),
        ],
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
