import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherSummaryIconWidget extends StatelessWidget {
  final String iconCode;

  WeatherSummaryIconWidget({required this.iconCode});

  @override
  Widget build(BuildContext context) {
    String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    return Image.network(
      iconUrl,
      width: 100, // Adjust the width and height as needed
      height: 100,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Icon(Icons.error);
      },
    );
  }
}
