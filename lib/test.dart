import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// void main() => runApp(MaterialApp(
//     theme: ThemeData(
//       fontFamily: 'Poppins',
//
//       colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//       useMaterial3: true,
//     ),
//     home: BarChartSample()
// ));

class BarChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bar Chart Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 150, // Increased height to accommodate title
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
          child: Column( // Use a Column to stack the title and chart
            crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
            children: [
              // Title of the chart
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Activity Detcted', // Your chart title
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded( // Make the chart expand to fill available space
                child: BarChart(
                  BarChartData(
                    maxY: 10, // Maximum value for y-axis
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Removed left labels
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text('25', style: TextStyle(fontSize: 16, color: Colors.white));
                              case 8:
                                return const Text('2', style: TextStyle(fontSize: 16, color: Colors.white));
                              case 16:
                                return const Text('10', style: TextStyle(fontSize: 16, color: Colors.white));
                              case 24:
                                return const Text('18', style: TextStyle(fontSize: 16, color: Colors.white));
                              default:
                                return const Text('');
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
                    barGroups: _getBarGroups(), // Call the function to get bar groups
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to generate the BarChartGroupData
  List<BarChartGroupData> _getBarGroups() {
    return [
      _createBarGroup(0, 8),
      _createBarGroup(1, 6),
      _createBarGroup(2, 7),
      _createBarGroup(3, 5),
      _createBarGroup(4, 9),
      _createBarGroup(5, 4),
      _createBarGroup(6, 8),
      _createBarGroup(7, 2),
      _createBarGroup(8, 3),
      _createBarGroup(9, 7),
      _createBarGroup(10, 6),
      _createBarGroup(11, 5),
      _createBarGroup(12, 9),
      _createBarGroup(13, 2),
      _createBarGroup(14, 8),
      _createBarGroup(15, 5),
      _createBarGroup(16, 4),
      _createBarGroup(17, 8),
      _createBarGroup(18, 3),
      _createBarGroup(19, 3),
      _createBarGroup(20, 7),
      _createBarGroup(21, 6),
      _createBarGroup(22, 5),
      _createBarGroup(23, 9),
      _createBarGroup(24, 1),
    ];
  }

  // Helper function to create a BarChartGroupData
  BarChartGroupData _createBarGroup(int x, double toY) {
    // Determine the color based on the value of x
    Color barColor = (toY > 8) ? Colors.yellow : Colors.white;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: toY,
          color: barColor, // Use the determined color
          width: 4,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

}
