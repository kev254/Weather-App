import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/controlers/weather_ctrl.dart';
import 'package:weatherapp/views/home_screen.dart';

import 'apis/constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherCtrl(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: Constants.primaryColor,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
