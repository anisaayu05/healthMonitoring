import 'package:flutter/material.dart';

import '../../../widgets/main_navigation.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "No Notifications",
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: MainNavigation(currentIndex: 2),
    );
  }
}
