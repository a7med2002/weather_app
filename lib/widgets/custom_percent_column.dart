import 'package:flutter/material.dart';
import 'package:starter_temp_weather_app/helper/color_helper.dart';

class CustomPercentColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  const CustomPercentColumn({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      children: [
        Icon(icon, color: whiteColor),
        Text(
          title,
          style: TextStyle(
            color: whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(color: whiteColor.withOpacity(0.7), fontSize: 12),
        ),
      ],
    );
  }
}
