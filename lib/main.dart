import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Widgets/main_widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'Widgets/Weather_tile.dart';

Future<WeatherInfo> fetchWeather() async {
  final zipCode = "629001";
  final apiKey = "062966779d9facc90f6113a41d475901";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?zip=$zipCode,in&units=metric&appid=$apiKey";

  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading request URL info");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  });
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: futureWeather,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return MainWidget(
              location: snapShot.data?.location,
              temp: snapShot.data?.temp,
              tempMin: snapShot.data?.tempMin,
              tempMax: snapShot.data?.tempMax,
              weather: snapShot.data?.weather,
              humidity: snapShot.data?.humidity,
              windSpeed: snapShot.data?.windSpeed,
            );
          } else if (snapShot.hasError) {
            return Center(child: Text("$snapShot.error"));
          }
          return Container();
        },
      ),
    );
  }
}
