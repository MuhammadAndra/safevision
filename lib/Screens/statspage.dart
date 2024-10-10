import 'package:flutter/material.dart';
import 'package:safevision/Widgets/ActivityChart.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';

List<String> list = <String>[
  'Last 25 days',
  'This month',
  'Last 6 month',
  'All time'
];

class Statspage extends StatelessWidget {
  final List<String> recordedName = [
    "Activity",
    "Suspicious\nActivity",
    "Microphone\nUsage",
    "Guest Count"
  ];
  final List<int> recordedCount = [68, 34, 21, 89];

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
                  DropdownMenuExample(),
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
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5, // Adjust the size of each tile
              ),
              shrinkWrap: true,
              // Allows GridView to fit the height of its content
              physics: NeverScrollableScrollPhysics(),
              // Disables GridView scrolling
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
    Color usedColor = Theme.of(context).colorScheme.surfaceContainerHigh;
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
              // Handle tap action
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    recordedName,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    recordedCount.toString(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
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

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
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
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
