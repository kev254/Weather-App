import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemperatureTrendsCard extends StatelessWidget {
  final List<dynamic> forecastData;

  TemperatureTrendsCard({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = forecastData.asMap().entries.map((entry) {
      int index = entry.key;
      var forecast = entry.value;
      return FlSpot(
        index.toDouble(),
        forecast['main']['temp'].toDouble(),
      );
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Temperature Trends',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 230,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 1,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}