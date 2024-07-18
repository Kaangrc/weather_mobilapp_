import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.101:8002/api/weather/';

  Future<WeatherData> fetchWeather(String city) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'city': city}),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(jsonDecode(response.body));
      return WeatherData.fromJson(data['data']);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
