import 'package:flutter/material.dart';
import '../apis/api_service.dart';

class WeatherCtrl with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<String, dynamic> _currentWeather = {};
  Map<String, dynamic> _forecast = {};

  /// Returns the current weather data.
  Map<String, dynamic> get currentWeather => _currentWeather;

  /// Returns the weather forecast data.
  Map<String, dynamic> get forecast => _forecast;

  /// Fetches current weather and forecast data for a given city.
  Future<void> fetchWeather(String city) async {
    try {
      _currentWeather = await _apiService.fetchCurrentWeather(city);
      _forecast = await _apiService.fetchForecast(city);
      notifyListeners();  // Notify listeners to update UI or perform other actions
    } catch (e) {
      // Handle exceptions and possibly notify listeners of the error
      print('Error fetching weather data: $e');
    }
  }
}
