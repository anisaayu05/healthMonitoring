import 'package:get/get.dart';

class HealthController extends GetxController {
  // Real-time simulated data
  var heartRateData = [
    {"value": 75, "time": "10:00 AM"},
    {"value": 78, "time": "10:30 AM"},
    {"value": 80, "time": "11:00 AM"}
  ].obs;

  var temperatureData = [
    {"value": 36.5, "time": "10:00 AM"},
    {"value": 36.7, "time": "10:30 AM"},
    {"value": 36.9, "time": "11:00 AM"}
  ].obs;

  List<Map<String, dynamic>> getDataForType(String type) {
    if (type == 'heartRate') return heartRateData;
    if (type == 'temperature') return temperatureData;
    return [];
  }
}
