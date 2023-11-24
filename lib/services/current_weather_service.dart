import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final String icon;
  final String city;
  final double temperature;
  final String weatherCondition;

  WeatherData({
    required this.icon,
    required this.city,
    required this.temperature,
    required this.weatherCondition,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      icon: json['current']['condition']['icon'],
      city: json['location']['name'],
      temperature: json['current']['temp_c'],
      weatherCondition: json['current']['condition']['text'],
    );
  }
}

class WeatherService {
  static const String _apiKey = '6b25e39a925a4187b5c72137232411';
  static const String _baseUrl = 'http://api.weatherapi.com/v1';

  Future<WeatherData> fetchWeatherData(String city) async {
    final url = '$_baseUrl/current.json?key=$_apiKey&q=$city&aqi=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final weatherObject = WeatherData.fromJson(jsonData);
      return weatherObject;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
