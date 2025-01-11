import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class MainNavigation extends StatelessWidget {
  final int currentIndex;

  const MainNavigation({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.toNamed(Routes.HOME);
            break;
          case 1:
            Get.toNamed(Routes.PROGRESS);
            break;
          case 2:
            Get.toNamed(Routes.NOTIFICATIONS);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: "Progress",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: "Notifications",
        ),
      ],
    );
  }
}
