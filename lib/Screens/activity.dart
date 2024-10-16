import 'package:flutter/material.dart';
import 'package:safevision/Screens/detailActivity.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/SectionTitle.dart';
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
      appBar: Appbarwidget(title: "Activity",subtitle: "3 new activity today",),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
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
                        color: Theme.of(context).colorScheme.secondary,
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
            child: ListView(
              children: [
                itemAktivitas('Orang Ketiga', '14:15:30', 'https://media.istockphoto.com/id/1330054759/photo/gift-gifting-with-family.jpg?s=612x612&w=0&k=20&c=zAmdxnDcDnmhbNGqVl30iGh0E5GcLOjk8uOiI6xxIBI='),
                itemAktivitas('Orang Kedua', '10:21:42', 'https://cdn.pixabay.com/photo/2023/11/02/05/23/woman-8359670_1280.png'),
                itemAktivitas('Orang Pertama', '09:05:20', 'https://cdn.pixabay.com/photo/2016/11/23/17/18/bed-1853907_1280.jpg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAktivitas(String nama, String waktu, String urlGambar) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail saat item ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAktivitasPage(
              nama: nama,
              waktu: waktu,
              urlGambar: urlGambar,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
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
                      nama,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(waktu),
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
                  image: NetworkImage(urlGambar),
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
