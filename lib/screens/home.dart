import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_temp_weather_app/helper/color_helper.dart';
import 'package:starter_temp_weather_app/models/weather.dart';
import 'package:starter_temp_weather_app/screens/country_picker.dart';
import 'package:starter_temp_weather_app/widgets/custom_hour_weather.dart';
import 'package:starter_temp_weather_app/widgets/custom_percent_column.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    Weather weather = Weather();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => selectedCountry != null
              ? weather.getCountryWeather(selectedCountry!, selectedCity!)
              : weather.getLocationWeather(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.24,
                      margin: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(24),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [blue2Color, blue1Color],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                      child: FutureBuilder(
                        future: selectedCountry != null
                            ? weather.getCountryWeather(
                                selectedCountry!,
                                selectedCity!,
                              )
                            : weather.getLocationWeather(context),

                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("${snapshot.error}"));
                          } else if (!snapshot.hasData) {
                            return Center(child: Text("No Data .."));
                          } else {
                            return Column(
                              spacing: 12,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: OutlinedButton(
                                        onPressed: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CountryPicker(),
                                            ),
                                          );
                                          if (result != null &&
                                              result is Map<String, String?>) {
                                            setState(() {
                                              selectedCountry =
                                                  result['country'];
                                              selectedState = result['state'];
                                              selectedCity = result['city'];
                                            });
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          iconColor: whiteColor,
                                          side: BorderSide(
                                            color: whiteColor.withOpacity(0.5),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  50,
                                                ),
                                          ),
                                          padding: EdgeInsets.all(0),
                                        ),
                                        child: Icon(Icons.menu, size: 24),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: whiteColor,
                                        ),
                                        Text(
                                          snapshot.data!["sys"]["country"]
                                              .toString(),
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.swap_calls_rounded,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 140,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      iconColor: whiteColor,
                                      side: BorderSide(
                                        color: whiteColor.withOpacity(0.5),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(50),
                                      ),
                                      padding: EdgeInsets.all(12),
                                    ),
                                    child: Row(
                                      spacing: 8,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "●",
                                          style: TextStyle(
                                            color: yellowColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!["name"].toString(),
                                          style: TextStyle(color: whiteColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      "https://openweathermap.org/img/wn/${snapshot.data!["weather"][0]["icon"]}@4x.png",
                                  width: 250,
                                  height: 220,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!["main"]["temp"]
                                              .toDouble()
                                              .toStringAsFixed(0),
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 120,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textHeightBehavior:
                                              TextHeightBehavior(
                                                applyHeightToFirstAscent: false,
                                                applyHeightToLastDescent: false,
                                              ),
                                        ),
                                        Text(
                                          "°",
                                          style: TextStyle(
                                            fontSize: 60,
                                            color: whiteColor.withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      snapshot.data!["weather"][0]["main"]
                                          .toString(),
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 26,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        "EEEE, dd MMMM",
                                      ).format(DateTime.now()),
                                      style: TextStyle(
                                        color: whiteColor.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: whiteColor.withOpacity(0.4)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomPercentColumn(
                                      icon: Icons.wind_power_outlined,
                                      title: snapshot.data!["wind"]["speed"]
                                          .toString(),
                                      subTitle: 'Wind',
                                    ),
                                    CustomPercentColumn(
                                      icon: Icons.water_drop,
                                      title: snapshot.data!["main"]["humidity"]
                                          .toString(),
                                      subTitle: 'Humidity',
                                    ),
                                    CustomPercentColumn(
                                      icon: Icons.cloud,
                                      title: snapshot.data!["clouds"]["all"]
                                          .toString(),
                                      subTitle: 'Clouds',
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                  child: Column(
                    spacing: 12,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "7 days",
                                style: TextStyle(color: fontColor),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: fontColor,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: selectedCountry != null
                            ? weather.getHourCountryWeather(
                                selectedCountry!,
                                selectedCity!,
                              )
                            : weather.getWeatherByHour(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData) {
                            return Text("No Data ..");
                          } else {
                            List<dynamic> forecastList = snapshot.data!['list'];
                            final todayForecast = forecastList.take(8).map((
                              item,
                            ) {
                              final time = item['dt_txt'].substring(11, 16);
                              final temp = item['main']['temp'].round();
                              final iconUrl =
                                  "https://openweathermap.org/img/wn/${item['weather'][0]['icon']}@2x.png";
                              return {
                                'temp': temp,
                                'time': time,
                                'iconUrl': iconUrl,
                              };
                            }).toList();
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: todayForecast
                                    .map(
                                      (forecast) => CustomHourWeather(
                                        temp: forecast['temp'],
                                        image: forecast['iconUrl'],
                                        hour: forecast['time'],
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
