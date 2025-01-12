#include <WiFi.h>
#include <HTTPClient.h>
#include <OneWire.h>
#include <DallasTemperature.h>

// Wi-Fi Credentials
#define WIFI_SSID "Modal dongg"  // Ganti dengan SSID Wi-Fi Anda
#define WIFI_PASSWORD "anisadisini"  // Ganti dengan password Wi-Fi Anda

// Cloud Functions URL
const char* serverName = "https://receivesensordata-fgc46dsfxa-uc.a.run.app";  // Ganti dengan URL Functions Anda

// Pin untuk Pulse Sensor dan DS18B20
#define PULSE_PIN 32  // Ganti dengan pin Pulse Sensor Anda
#define ONE_WIRE_BUS 4  // Ganti dengan pin DS18B20 Anda

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

void setup() {
  Serial.begin(115200);

  // Hubungkan ke Wi-Fi
  Serial.print("Connecting to Wi-Fi");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to Wi-Fi");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  // Inisialisasi DS18B20
  sensors.begin();
}

void loop() {
  // Baca data dari Pulse Sensor
  int pulseValue = analogRead(PULSE_PIN);
  int heartRate = map(pulseValue, 0, 4095, 60, 100);  // Pemetaan nilai ke rentang BPM

  // Baca data suhu dari DS18B20
  sensors.requestTemperatures();
  float temperature = sensors.getTempCByIndex(0);

  // Tampilkan data ke Serial Monitor
  Serial.print("Raw Pulse Value: ");
  Serial.println(pulseValue);
  Serial.print("Heart Rate: ");
  Serial.print(heartRate);
  Serial.println(" BPM");
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println(" °C");

  // Kirim data ke Cloud Functions
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;

    // Inisialisasi koneksi HTTP
    http.begin(serverName);
    http.addHeader("Content-Type", "application/json");  // Header untuk JSON

    // Format data JSON
    String jsonData = "{\"heartRate\":" + String(heartRate) + ",\"temperature\":" + String(temperature) + "}";

    // Kirim POST request
    int httpResponseCode = http.POST(jsonData);

    // Tampilkan hasil ke Serial Monitor
    if (httpResponseCode > 0) {
      Serial.print("HTTP Response code: ");
      Serial.println(httpResponseCode);
      String response = http.getString();  // Ambil respons dari server
      Serial.println("Response: " + response);
    } else {
      Serial.print("Error in sending POST: ");
      Serial.println(httpResponseCode);
    }

    // Tutup koneksi
    http.end();
  } else {
    Serial.println("Wi-Fi not connected");
  }

  // Delay 10 detik sebelum pengiriman data berikutnya
  delay(10000);
}
