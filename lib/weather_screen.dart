import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  Future getCurrentWeather() async {
    String city = "Madurai";
    http.get(
      Uri.parse(
          "http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$openWeatherApiKey"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WeatherApp",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => print("refresh"),
              icon: const Icon(Icons.refresh_sharp))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "30.98°C",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 72,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Raining",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Weather ForeCast",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ForeCastItem(
                      time: "00:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "15°C"),
                  ForeCastItem(
                      time: "03:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "12°C"),
                  ForeCastItem(
                      time: "06:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "16°C"),
                  ForeCastItem(
                      time: "09:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "21°C"),
                  ForeCastItem(
                      time: "12:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "26°C"),
                  ForeCastItem(
                      time: "15:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "24°C"),
                  ForeCastItem(
                      time: "18:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "19°C"),
                  ForeCastItem(
                      time: "21:00",
                      icon: Icon(Icons.cloud, size: 32),
                      temperature: "17°C")
                ],
              ),
            ),
            SizedBox(height: 25),
            Text("Additional Information",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalItems(
                      info: "Humidity",
                      icon: Icon(
                        Icons.water_drop_sharp,
                        size: 32,
                      ),
                      value: "94"),
                  AdditionalItems(
                      info: "WindSpeed",
                      icon: Icon(
                        Icons.air,
                        size: 32,
                      ),
                      value: "7.67"),
                  AdditionalItems(
                      info: "Pressure",
                      icon: Icon(
                        Icons.speed,
                        size: 32,
                      ),
                      value: "1006")
                ]),
          ],
        ),
      ),
    );
  }
}

class AdditionalItems extends StatelessWidget {
  final String info;
  final Icon icon;
  final String value;
  const AdditionalItems(
      {required this.info, required this.icon, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          icon,
          SizedBox(height: 8),
          Text(info, style: TextStyle(fontSize: 14)),
          SizedBox(height: 8),
          Text(value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

class ForeCastItem extends StatelessWidget {
  final String time;
  final Icon icon;
  final String temperature;
  const ForeCastItem(
      {super.key,
      required this.time,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            icon,
            const SizedBox(height: 8),
            Text(temperature,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
