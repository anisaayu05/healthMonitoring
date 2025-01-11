import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../widgets/main_navigation.dart';

class ProgressView extends StatefulWidget {
  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  final DatabaseReference _heartRateRef = FirebaseDatabase.instance.ref().child('sensorData/heartRate');
  final DatabaseReference _temperatureRef = FirebaseDatabase.instance.ref().child('sensorData/temperature');
  
  List<FlSpot> heartRateData = [];
  List<BarChartGroupData> temperatureData = [];

  @override
  void initState() {
    super.initState();

    // Mendengarkan perubahan pada data heart rate
    _heartRateRef.onValue.listen((event) {
      setState(() {
        heartRateData = [
          FlSpot(0, event.snapshot.value != null ? (event.snapshot.value as int).toDouble() : 0.0),  // Menggunakan null check
        ];
      });
    });

    // Mendengarkan perubahan pada data suhu
    _temperatureRef.onValue.listen((event) {
      setState(() {
        temperatureData = [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: (event.snapshot.value as num?)?.toDouble() ?? 0.0, color: Colors.redAccent, width: 16)  // Menggunakan null check
          ]),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Progress",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Heart Rate Chart
            StatCardWithChart(
              title: "Heart Rate",
              subtitle: "Beats Per Minute",
              chart: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          // Menyesuaikan dengan tanggal hari ini
                          DateTime now = DateTime.now();
                          int currentDay = (now.weekday + value.toInt()) % 7;  // Menambahkan offset hari ke tanggal
                          const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                          return Text(
                            days[currentDay],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: heartRateData,
                      isCurved: true,
                      barWidth: 4,
                      color: Colors.blue,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            // Body Temperature Chart
            StatCardWithChart(
              title: "Body Temperature",
              subtitle: "In °C",
              chart: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          // Menyesuaikan dengan tanggal hari ini
                          DateTime now = DateTime.now();
                          int currentDay = (now.weekday + value.toInt()) % 7;  // Menambahkan offset hari ke tanggal
                          const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                          return Text(
                            days[currentDay],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: temperatureData,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigation(currentIndex: 1),
    );
  }
}

// Class untuk kartu statistik dengan grafik
class StatCardWithChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget chart;

  const StatCardWithChart({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 16),
          SizedBox(height: 200, child: chart),
        ],
      ),
    );
  }
}
