import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controlers/weather_ctrl.dart';
import '../widgets/focus_card.dart';
import '../widgets/temperature_trend.dart';

class TemperatureTrendsScreen extends StatefulWidget {
  @override
  State<TemperatureTrendsScreen> createState() => _TemperatureTrendsScreenState();
}

class _TemperatureTrendsScreenState extends State<TemperatureTrendsScreen> {


  @override
  Widget build(BuildContext context) {
    final weatherCtrl = Provider.of<WeatherCtrl>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Trends'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [


            SizedBox(height: 20),
            if (weatherCtrl.currentWeather.isEmpty || weatherCtrl.forecast.isEmpty)
              CircularProgressIndicator(),
            if (weatherCtrl.currentWeather.isNotEmpty && weatherCtrl.forecast.isNotEmpty) ...[

              SizedBox(height: 10),
              // Temperature Trends Summary
              SizedBox(
                width: double.infinity,
                child: TemperatureTrendsCard(
                  forecastData: weatherCtrl.forecast['list'],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
