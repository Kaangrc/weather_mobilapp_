class WeatherData {
  final double temperature;
  final String date;
  final String imageUrl;

  WeatherData({
    required this.temperature,
    required this.date,
    required this.imageUrl,
  });

  // JSON'dan model oluşturma
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['temperature'],
      date: json['date'],
      imageUrl: json['image_url'],
    );
  }

  // Modelden JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'date': date,
      'image_url': imageUrl,
    };
  }
}
