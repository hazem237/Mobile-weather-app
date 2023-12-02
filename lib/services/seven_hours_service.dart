import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final String time;
  final double currentTempC;
  final String currentConditionText;
  final String currentConditionIcon;

  WeatherData({
    required this.time,
    required this.currentTempC,
    required this.currentConditionText,
    required this.currentConditionIcon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      time: json['time'] ?? '',
      currentTempC: (json['temp_c']).toDouble(),
      currentConditionText: json['condition']['text'],
      currentConditionIcon: json['condition']['icon'],
    );
  }
}

class WeatherService {
  static const String _apiKey = '6b25e39a925a4187b5c72137232411';
  static const String _baseUrl = 'http://api.weatherapi.com/v1';

  Future<List<WeatherData>> fetchWeather(String cityName) async {
    final url =
        '$_baseUrl/forecast.json?key=$_apiKey&q=$cityName&days=1&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final currentHourEpoch = jsonData['current']['last_updated_epoch'] as int;
      final forecast =
          jsonData['forecast']['forecastday'][0]['hour'] as List<dynamic>;
      final currentHourIndex = forecast.indexWhere((hourData) {
        final hourEpoch = hourData['time_epoch'] as int;
        return hourEpoch >= currentHourEpoch;
      });

      List<WeatherData> nextHoursWeather = [];

      if (currentHourIndex != -1) {
        for (int i = currentHourIndex + 1; i < currentHourIndex + 8; i++) {
          if (i < forecast.length) {
            final hourWeather = forecast[i];
            nextHoursWeather.add(WeatherData.fromJson(hourWeather));
          }
        }
      }

      return nextHoursWeather;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
