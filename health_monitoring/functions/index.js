const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.database();

// Function untuk menerima data dari ESP32
exports.receiveSensorData = functions.https.onRequest((req, res) => {
  // Mendapatkan data dari request body
  const heartRate = req.body.heartRate;
  const temperature = req.body.temperature;

  // Validasi data
  if (heartRate === undefined || temperature === undefined) {
    return res.status(400).send(
        "Missing heartRate or temperature in the request body.",
    );
  }

  // Simpan data ke Realtime Database
  const ref = db.ref("/sensorData");
  const data = {
    heartRate: heartRate,
    temperature: temperature,
    timestamp: Date.now(),
  };

  ref.push(data, (error) => {
    if (error) {
      console.error("Error saving data:", error);
      res.status(500).send("Error saving data to Firebase.");
    } else {
      console.log("Data saved successfully:", data);
      res.status(200).send("Data received and saved successfully.");
    }
  });
});
