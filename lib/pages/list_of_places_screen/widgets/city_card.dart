import 'package:flutter/material.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';
import 'package:weather_flutter_app/pages/list_of_places_screen/widgets/moreDetailsDialog.dart';

class CityCard extends StatefulWidget {
  final WeatherData weatherData;

  const CityCard({required this.weatherData});

  @override
  _CityCardState createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isHovered ? 8 : 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: isHovered ? Colors.blueGrey[100] : Colors.white,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https:${widget.weatherData.icon}',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(widget.weatherData.city),
                      const SizedBox(height: 4),
                      Text(widget.weatherData.weatherCondition),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.weatherData.temperature.toString()}°C',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MoreDetailsDialog(
                                weatherData: widget.weatherData,
                              );
                            },
                          );
                        },
                        child: const Text('More Details'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
