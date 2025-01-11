import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class HealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthController>(() => HealthController());
  }
}
