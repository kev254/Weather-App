import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controlers/weather_ctrl.dart';
import '../widgets/focus_card.dart';

class ForecastScreen extends StatefulWidget {
  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {


  @override
  Widget build(BuildContext context) {
    final weatherCtrl = Provider.of<WeatherCtrl>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [


            SizedBox(height: 20),
            if (weatherCtrl.currentWeather.isEmpty || weatherCtrl.forecast.isEmpty)
              CircularProgressIndicator(),
            if (weatherCtrl.currentWeather.isNotEmpty && weatherCtrl.forecast.isNotEmpty) ...[

              // Forecast Summary
              SizedBox(
                width: double.infinity,
                child: ForecastSummaryCard(
                  forecastData: weatherCtrl.forecast['list'],
                ),
              ),
              SizedBox(height: 10),
              // Temperature Trends Summary
              // SizedBox(
              //   width: double.infinity,
              //   child: TemperatureTrendsCard(
              //     forecastData: weatherCtrl.forecast['list'],
              //   ),
              // ),
            ],
          ],
        ),
      ),
    );
  }
}
