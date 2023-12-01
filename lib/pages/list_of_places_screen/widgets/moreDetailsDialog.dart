import 'package:flutter/material.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';

class MoreDetailsDialog extends StatelessWidget {
  final WeatherData weatherData;

  const MoreDetailsDialog({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('More Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _buildDetails(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  List<Widget> _buildDetails() {
    return [
      _buildDetailRow('Name:', weatherData.city),
      _buildDetailRow('Region:', weatherData.region),
      _buildDetailRow('Country:', weatherData.country),
      _buildDetailRow('Local Time:', weatherData.localtime),
    ];
  }

  Widget _buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
