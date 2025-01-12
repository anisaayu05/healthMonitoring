import 'package:flutter/material.dart';

import '../../../widgets/main_navigation.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
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
            // Notifikasi pertama: Detak Jantung Tinggi
            NotificationTile(
              icon: Icons.favorite,
              title: "Heart Rate Warning",
              message: "Heart rate is above normal. Please check the user.",
              color: Colors.redAccent,
            ),
            // Notifikasi kedua: Suhu Tubuh Tidak Normal
            NotificationTile(
              icon: Icons.thermostat,
              title: "Temperature Alert",
              message: "The user's body temperature is higher than normal.",
              color: Colors.orangeAccent,
            ),
            // Notifikasi ketiga: Pemeriksaan Rutin
            NotificationTile(
              icon: Icons.medical_services, // Ganti dengan ikon yang sesuai
              title: "Routine Checkup Reminder",
              message: "It's time for a routine medical checkup.",
              color: Colors.greenAccent,
            ),
            // Notifikasi keempat: Pengingat Obat
            NotificationTile(
              icon: Icons.medication, // Ganti dengan ikon yang sesuai
              title: "Medication Reminder",
              message: "Don't forget to take your medicine.",
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigation(currentIndex: 2),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Color color;

  const NotificationTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: color),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
