import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/summary_icon.dart';

class WeatherSummaryCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> weatherData;

  WeatherSummaryCard({required this.title, required this.weatherData});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${weatherData['main']['temp']}°C',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${weatherData['weather'][0]['description']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weather: ${weatherData['weather'][0]['main']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Humidity: ${weatherData['main']['humidity']}%',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Wind Speed: ${weatherData['wind']['speed']} m/s',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                WeatherSummaryIconWidget(iconCode: weatherData['weather'][0]['icon']),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
