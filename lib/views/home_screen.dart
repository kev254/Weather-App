import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp/apis/constants.dart';
import 'package:weatherapp/views/temperature_trends_screen.dart';
import '../controlers/weather_ctrl.dart';
import '../widgets/focus_card.dart';
import '../widgets/home_summary_card.dart';
import '../widgets/temperature_trend.dart';
import 'forecast_screen.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  String? city;

  @override
  void initState() {
    super.initState();
    fetchWeatherDataForCurrentLocation();
  }

  @override
  void dispose(){
    super.dispose();
    _cityController.dispose();
  }

  Future<void> fetchWeatherDataForCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      city = placemarks.first.locality ?? placemarks.first.administrativeArea;

      await Provider.of<WeatherCtrl>(context, listen: false).fetchWeather(city!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherCtrl = Provider.of<WeatherCtrl>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, right: 16),
                  child: Text(
                    city ?? "Unknown City",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding
                      child: TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: 'Search other cities',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // Add border radius
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // Add focused border radius
                            borderSide: BorderSide(color: Colors.blue), // Add focused border color
                          ),
                          suffixIcon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Shape as circle
                              color: Colors.grey[300], // Grey background color
                            ),
                            child: IconButton(
                              icon: Icon(Icons.search, color: Colors.black), // Change arrow icon to search icon
                              onPressed: () async {
                                try {
                                  if(_cityController.text !=null && _cityController.text != ""){
                                    await weatherCtrl.fetchWeather(_cityController.text);
                                    setState(() {
                                      city=_cityController.text;
                                    });
                                  }
                                  else{
                                    print("Error: City cannot be null ");
                                  }

                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              if (weatherCtrl.currentWeather.isEmpty || weatherCtrl.forecast.isEmpty)
                CircularProgressIndicator(),
              if (weatherCtrl.currentWeather.isNotEmpty && weatherCtrl.forecast.isNotEmpty) ...[
                // Current Weather Summary
                SizedBox(
                  width: double.infinity,
                  child: WeatherSummaryCard(
                    title: 'Current Weather',
                    weatherData: weatherCtrl.currentWeather,
                  ),
                ),
                SizedBox(height: 10),
                // Forecast Summary
                SizedBox(
                  width: double.infinity,
                  child: ForecastSummaryCard(
                    forecastData: weatherCtrl.forecast['list'],
                  ),
                ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Current Weather'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Forecast'),
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(ForecastScreen());

                      },
                    ),
                    ListTile(
                      title: Text('Temperature Trends'),
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(TemperatureTrendsScreen());
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.menu),
      ),
    );
  }
}
