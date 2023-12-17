import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final String cityName;
  final double forecastTempC;
  final double maxTempC;
  final double minTempC;
  final String forecastConditionText;
  final String forecastConditionIcon;

  WeatherData({
    required this.cityName,
    required this.forecastTempC,
    required this.maxTempC,
    required this.minTempC,
    required this.forecastConditionText,
    required this.forecastConditionIcon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json, int index) {
    final forecast = json['forecast']['forecastday'][index]['day'];

    return WeatherData(
      cityName: json['location']['name'],
      forecastTempC: (forecast['avgtemp_c']),
      maxTempC: (forecast['maxtemp_c']),
      minTempC: (forecast['mintemp_c']),
      forecastConditionText: forecast['condition']['text'],
      forecastConditionIcon: forecast['condition']['icon'],
    );
  }
}

class WeatherService {
  static const String _apiKey =
      '6b25e39a925a4187b5c72137232411'; 
  static const String _baseUrl = 'http://api.weatherapi.com/v1';

  Future<List<WeatherData>> fetchWeather(String cityName) async {
    final url =
        '$_baseUrl/forecast.json?key=$_apiKey&q=$cityName&days=7&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<WeatherData> weatherDataList = [];

      for (int i = 0; i < 3; i++) {
        weatherDataList.add(WeatherData.fromJson(jsonData, i));
      }

      return weatherDataList;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
