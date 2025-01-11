import 'package:get/get.dart';

class ProgressController extends GetxController {
  final heartRateData = [
    {"value": 70, "day": "Sun"},
    {"value": 72, "day": "Mon"},
    {"value": 74, "day": "Tue"},
  ].obs;

  final breathRateData = [
    {"value": 18, "day": "Sun"},
    {"value": 20, "day": "Mon"},
    {"value": 19, "day": "Tue"},
  ].obs;
}
