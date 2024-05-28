import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ApiService {
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final String url = '${Constants.weatherUrl}/weather?q=$city&appid=${Constants.apiKey}&units=metric';
    return _fetchData(url);
  }

  Future<Map<String, dynamic>> fetchForecast(String city) async {
    final String url = '${Constants.weatherUrl}/forecast?q=$city&appid=${Constants.apiKey}&units=metric';
    return _fetchData(url);
  }

  Future<Map<String, dynamic>> _fetchData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
