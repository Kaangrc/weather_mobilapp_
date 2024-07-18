import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  WeatherWidget({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'City: ${weatherData.date}',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          'Temperature: ${weatherData.temperature}°C',
          style: TextStyle(fontSize: 20),
        ),
        Image.network(
          'http://openweathermap.org/img/w/${weatherData}.png',
          width: 100,
        ),
      ],
    );
  }
}
