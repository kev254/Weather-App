import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_icon.dart';

class ForecastSummaryCard extends StatelessWidget {
  final List<dynamic> forecastData;

  ForecastSummaryCard({required this.forecastData});

  String getDayOfWeek(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days[date.weekday % 7];
  }

  String getTimeOfDay(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    int hour = date.hour;
    if (hour < 12) {
      return "Morning";
    } else if (hour < 18) {
      return "Afternoon";
    } else {
      return "Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forecast (Next 5 days)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Day/Time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Icon',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Temperature',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Humidity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            for (var i = 0; i < 5; i++) // Displaying 5 forecasts
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getDayOfWeek(forecastData[i]['dt_txt']),
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          getTimeOfDay(forecastData[i]['dt_txt']),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    WeatherIconWidget(
                      iconCode: '${forecastData[i]['weather'][0]['icon']}',
                    ),
                    Text(
                      '${forecastData[i]['main']['temp']}°C',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${forecastData[i]['main']['humidity']}%',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
