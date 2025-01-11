import 'package:get/get.dart';

class HomeController extends GetxController {
  // Example: List of welcome messages or some initial data
  var welcomeMessage = "Welcome to the Health App!".obs;

  void updateMessage(String newMessage) {
    welcomeMessage.value = newMessage;
  }
}
