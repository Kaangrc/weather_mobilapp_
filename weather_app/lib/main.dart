import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  String? _city;
  WeatherData? _weatherData;

  final ApiService apiService = ApiService();

  Future<void> _fetchWeather(String city) async {
    // Önceki sonuçları sıfırlamak için setState kullanıyoruz
    setState(() {
      _weatherData = null;
    });

    try {
      final fetchedWeatherData = await apiService.fetchWeather(city);
      if (fetchedWeatherData != null) {
        setState(() {
          _weatherData = fetchedWeatherData;
        });
      } else {
        _showErrorDialog('Şehir bilgisine ulaşılamadı');
      }
    } catch (e) {
      print(e);
      _showErrorDialog('Şehir bilgisine ulaşılamadı');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Hata'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Tamam'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter City'),
              onChanged: (value) {
                _city = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_city != null && _city!.isNotEmpty) {
                  _fetchWeather(_city!);
                }
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            if (_weatherData != null) WeatherWidget(weatherData: _weatherData!),
          ],
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final WeatherData weatherData;

  WeatherWidget({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Temperature: ${weatherData.temperature}°C'),
        Text('Date: ${weatherData.date}'),
        Image.network(weatherData.imageUrl), // Yeni eklenen alan
      ],
    );
  }
}
