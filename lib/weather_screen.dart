import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String city = "Madurai";
      final res = await http.get(
        Uri.parse(
            "http://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$openWeatherApiKey"),
      );

      final data = jsonDecode(res.body);
      if (data['cod'] != "200") {
        throw "Error 200 happend bro!";
      }

      // temp = (data['list'][0]['main']['temp']);
      // temp = double.parse((temp - 273).toStringAsFixed(1));
      return data;

      // print("The Temperature Is $temp");
    } catch (e) {
      throw e.toString();
    }
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
              onPressed: () => setState(() {
                
              }),
              icon: const Icon(Icons.refresh_sharp))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data;
          final currentWeatherData = data['list'][0];
          final currentTemp = (currentWeatherData['main']['temp']);
          final currentTempinC = (currentTemp - 273).toStringAsFixed(1);
          final currentSky = (currentWeatherData['weather'][0]['main']);
          final currentHumidity =
              (currentWeatherData['main']['humidity']).toString();
          final currentPressure =
              (currentWeatherData['main']['pressure']).toString();
          final currentWindSpeed =
              (currentWeatherData['wind']['speed'].toString());

          return Padding(
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
                                "$currentTempinC°C",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Icon(
                                currentSky == "Clouds" || currentSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.wb_sunny,
                                size: 72,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                currentSky,
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
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index];

                        final time = DateTime.parse(hourlyForecast["dt_txt"]);
                        final temperatureinC =
                            (hourlyForecast['main']['temp'] - 273)
                                    .toStringAsFixed(1) +
                                "°C";
                        return ForeCastItem(
                            time: DateFormat.j().format(time).toString(),
                            icon: Icon(Icons.cloud),
                            temperature: temperatureinC);
                      }),
                ),
                SizedBox(height: 25),
                Text("Additional Information",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                          value: currentHumidity),
                      AdditionalItems(
                          info: "WindSpeed",
                          icon: Icon(
                            Icons.air,
                            size: 32,
                          ),
                          value: currentWindSpeed),
                      AdditionalItems(
                          info: "Pressure",
                          icon: Icon(
                            Icons.speed,
                            size: 32,
                          ),
                          value: currentPressure)
                    ]),
              ],
            ),
          );
        },
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
