import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../widgets/main_navigation.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DatabaseReference _heartRateRef = FirebaseDatabase.instance.ref().child('sensorData/heartRate');
  final DatabaseReference _temperatureRef = FirebaseDatabase.instance.ref().child('sensorData/temperature');
  
  int heartRate = 0;
  double temperature = 0.0;

  @override
  void initState() {
    super.initState();
    _heartRateRef.onValue.listen((event) {
      setState(() {
        heartRate = event.snapshot.value != null ? (event.snapshot.value as int) : 0;
      });
    });
    _temperatureRef.onValue.listen((event) {
      setState(() {
        temperature = event.snapshot.value != null ? (event.snapshot.value as double) : 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.person, color: Colors.blue),
            ),
          ),
          actions: [
            // Ganti ikon notifikasi dengan ikon pengaturan
            IconButton(
              icon: Icon(Icons.settings, color: Colors.grey[700]),
              onPressed: () {
                // Tindakan untuk membuka pengaturan atau halaman terkait
                print("Settings tapped");
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Have a Nice Day!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your Health Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            // Weekly Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print("Selected date: $formattedDate");
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        "Weekly",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Health Cards (Only showing Heart Rate and Body Temperature)
            Expanded(
              child: ListView(
                children: [
                  HealthStatCard(
                    icon: Icons.favorite_rounded,
                    title: "Heart Rate",
                    value: "$heartRate BPM", // Update this dynamically
                    color: Colors.green[100]!,
                    onTap: () {},
                  ),
                  HealthStatCard(
                    icon: Icons.thermostat_rounded,
                    title: "Body Temperature",
                    value: "$temperature °C", // Update this dynamically
                    color: Colors.orange[100]!,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigation(currentIndex: 0),
    );
  }
}

class HealthStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const HealthStatCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: Icon(icon, size: 28, color: Colors.black54),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
