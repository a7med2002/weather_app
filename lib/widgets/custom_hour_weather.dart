import 'package:flutter/widgets.dart';
import 'package:starter_temp_weather_app/helper/color_helper.dart';

class CustomHourWeather extends StatelessWidget {
  final int temp;
  final String image;
  final String hour;
  const CustomHourWeather({super.key, required this.temp, required this.image, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: fontColor),
      ),
      child: Column(
        children: [
          Text(
            "$temp°",
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
          ),
          Image.asset("assets/images/$image", width: 40, height: 40),
          Text(
            hour,
            style: TextStyle(color: whiteColor.withOpacity(0.7), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
