import 'package:flutter/material.dart';
import 'package:starter_temp_weather_app/helper/color_helper.dart';
import 'package:starter_temp_weather_app/models/weather.dart';
import 'package:starter_temp_weather_app/screens/home.dart';

class LoadingState extends StatefulWidget {
  const LoadingState({super.key});

  @override
  State<LoadingState> createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState> {
  // @override
  // void initState() {
  //   super.initState();
  //   getLocationWeather();
  // }

  // void getLocationWeather() {
  //   Weather weather = Weather();
  //   weather
  //       .getLocationWeather(context)
  //       .then((value) {
  //         if (mounted) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => Home()),
  //           );
  //         }
  //       })
  //       .catchError((e) => print("Error: $e"));
  // }

  // UserLocation userLocation = UserLocation();
  // await userLocation.getUserLocation(context);
  // Map<String, dynamic> weatherData = await NetworkHelper(
  //   "https://api.openweathermap.org/data/2.5/weather?lat=${userLocation.latitude}&lon=${userLocation.longitude}&appid=$apiKey",
  // ).getData();
  // print(weatherData);

  // Future<Map<String, dynamic>> getData(double lat, double long) async {
  //   String url =
  //       "https://api.openweathermap.org/data/2.5/weather?$lat=44.34&$long=10.99&appid=$apiKey";

  //   http.Response response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     String responseBody = response.body;
  //     Map<String, dynamic> bodyData = jsonDecode(responseBody);
  //     return Future.value(bodyData);
  //   }
  //   return Future.error("Error Get Data: $e");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: CircularProgressIndicator(color: whiteColor)),
    );
  }
}
