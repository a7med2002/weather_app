import 'package:flutter/material.dart';
import 'package:starter_temp_weather_app/helper/constants.dart';
import 'package:starter_temp_weather_app/helper/network_helper.dart';
import 'package:starter_temp_weather_app/models/user_location.dart';

class Weather {
  late String country;
  late String city;
  late String temp;
  late String weatherState;
  late String wind;
  late String humidity;
  late String clouds;
  late String weatherStateImg;

  // Weather({
  //   required this.country,
  //   required this.city,
  //   required this.clouds,
  //   required this.humidity,
  //   required this.temp,
  //   required this.weatherState,
  //   required this.wind,
  // });

  Future<Map<String, dynamic>> getLocationWeather(BuildContext context) async {
    UserLocation userLocation = UserLocation();
    await userLocation.getUserLocation(context);
    Map<String, dynamic> weatherData = await NetworkHelper(
      "https://api.openweathermap.org/data/2.5/weather?lat=${userLocation.latitude}&lon=${userLocation.longitude}&appid=$apiKey",
    ).getData();

    country = weatherData["sys"]["country"].toString();
    city = weatherData["name"].toString();
    temp = weatherData["main"]["temp"].toDouble().toStringAsFixed(0);
    weatherState = weatherData["weather"][0]["main"].toString();
    wind = weatherData["wind"]["speed"].toString();
    humidity = weatherData["main"]["humidity"].toString();
    clouds = weatherData["clouds"]["all"].toString();
    weatherStateImg = weatherData["weather"][0]["icon"];
    // weatherStateImg = getWeatherImage(weatherData["weather"][0]["id"]);
    return weatherData;
  }

  Future<Map<String, dynamic>> getCountryWeather(
    String countryName,
    String city,
  ) async {
    final Map<String, String> countryCodes = {
      'Qatar': 'QA',
      'Palestine': 'PS',
      'United States': 'US',
      'Egypt': 'EG',
      'Jordan': 'JO',
      'Saudi Arabia': 'SA',
      'Turkey': 'TR',
      'Germany': 'DE',
      'France': 'FR',
      'United Kingdom': 'GB',
      'Afghanistan': 'AF',
      'Albania': 'AL',
      'Algeria': 'DZ',
      'Andorra': 'AD',
      'Angola': 'AO',
      'Argentina': 'AR',
      'Armenia': 'AM',
      'Australia': 'AU',
      'Austria': 'AT',
      'Azerbaijan': 'AZ',
      'Bahamas': 'BS',
      'Bahrain': 'BH',
      'Bangladesh': 'BD',
      'Barbados': 'BB',
      'Belarus': 'BY',
      'Belgium': 'BE',
      'Belize': 'BZ',
      'Benin': 'BJ',
      'Bhutan': 'BT',
      'Bolivia': 'BO',
      'Bosnia and Herzegovina': 'BA',
      'Botswana': 'BW',
      'Brazil': 'BR',
      'Brunei': 'BN',
      'Bulgaria': 'BG',
      'Burkina Faso': 'BF',
      'Burundi': 'BI',
      'Cambodia': 'KH',
      'Cameroon': 'CM',
      'Canada': 'CA',
      'Cape Verde': 'CV',
      'Central African Republic': 'CF',
      'Chad': 'TD',
      'Chile': 'CL',
      'China': 'CN',
      'Colombia': 'CO',
      'Comoros': 'KM',
      'Costa Rica': 'CR',
      'Croatia': 'HR',
      'Cuba': 'CU',
      'Cyprus': 'CY',
      'Czech Republic': 'CZ',
      'Denmark': 'DK',
      'Djibouti': 'DJ',
      'Dominica': 'DM',
      'Dominican Republic': 'DO',
      'Ecuador': 'EC',
      'El Salvador': 'SV',
      'Equatorial Guinea': 'GQ',
      'Eritrea': 'ER',
      'Estonia': 'EE',
      'Eswatini': 'SZ',
      'Ethiopia': 'ET',
      'Fiji': 'FJ',
      'Finland': 'FI',
      'Gabon': 'GA',
      'Gambia': 'GM',
      'Georgia': 'GE',
      'Ghana': 'GH',
      'Greece': 'GR',
      'Grenada': 'GD',
      'Guatemala': 'GT',
      'Guinea': 'GN',
      'Guinea-Bissau': 'GW',
      'Guyana': 'GY',
      'Haiti': 'HT',
      'Honduras': 'HN',
      'Hungary': 'HU',
      'Iceland': 'IS',
      'India': 'IN',
      'Indonesia': 'ID',
      'Iran': 'IR',
      'Iraq': 'IQ',
      'Ireland': 'IE',
      'Israel': 'IL',
      'Italy': 'IT',
      'Ivory Coast': 'CI',
      'Jamaica': 'JM',
      'Japan': 'JP',
      'Kazakhstan': 'KZ',
      'Kenya': 'KE',
      'Kiribati': 'KI',
      'Kuwait': 'KW',
      'Kyrgyzstan': 'KG',
      'Laos': 'LA',
      'Latvia': 'LV',
      'Lebanon': 'LB',
      'Lesotho': 'LS',
      'Liberia': 'LR',
      'Libya': 'LY',
      'Liechtenstein': 'LI',
      'Lithuania': 'LT',
      'Luxembourg': 'LU',
      'Madagascar': 'MG',
      'Malawi': 'MW',
      'Malaysia': 'MY',
      'Maldives': 'MV',
      'Mali': 'ML',
      'Malta': 'MT',
      'Mauritania': 'MR',
      'Mauritius': 'MU',
      'Mexico': 'MX',
      'Moldova': 'MD',
      'Monaco': 'MC',
      'Mongolia': 'MN',
      'Montenegro': 'ME',
      'Morocco': 'MA',
      'Mozambique': 'MZ',
      'Myanmar': 'MM',
      'Namibia': 'NA',
      'Nepal': 'NP',
      'Netherlands': 'NL',
      'New Zealand': 'NZ',
      'Nicaragua': 'NI',
      'Niger': 'NE',
      'Nigeria': 'NG',
      'North Korea': 'KP',
      'North Macedonia': 'MK',
      'Norway': 'NO',
      'Oman': 'OM',
      'Pakistan': 'PK',
      'Panama': 'PA',
      'Papua New Guinea': 'PG',
      'Paraguay': 'PY',
      'Peru': 'PE',
      'Philippines': 'PH',
      'Poland': 'PL',
      'Portugal': 'PT',
      'Romania': 'RO',
      'Russia': 'RU',
      'Rwanda': 'RW',
      'Saint Kitts and Nevis': 'KN',
      'Saint Lucia': 'LC',
      'Saint Vincent and the Grenadines': 'VC',
      'Samoa': 'WS',
      'San Marino': 'SM',
      'Sao Tome and Principe': 'ST',
      'Senegal': 'SN',
      'Serbia': 'RS',
      'Seychelles': 'SC',
      'Sierra Leone': 'SL',
      'Singapore': 'SG',
      'Slovakia': 'SK',
      'Slovenia': 'SI',
      'Solomon Islands': 'SB',
      'Somalia': 'SO',
      'South Africa': 'ZA',
      'South Korea': 'KR',
      'South Sudan': 'SS',
      'Spain': 'ES',
      'Sri Lanka': 'LK',
      'Sudan': 'SD',
      'Suriname': 'SR',
      'Sweden': 'SE',
      'Switzerland': 'CH',
      'Syria': 'SY',
      'Taiwan': 'TW',
      'Tajikistan': 'TJ',
      'Tanzania': 'TZ',
      'Thailand': 'TH',
      'Timor-Leste': 'TL',
      'Togo': 'TG',
      'Tonga': 'TO',
      'Trinidad and Tobago': 'TT',
      'Tunisia': 'TN',
      'Turkmenistan': 'TM',
      'Tuvalu': 'TV',
      'Uganda': 'UG',
      'Ukraine': 'UA',
      'United Arab Emirates': 'AE',

      'Uruguay': 'UY',
      'Uzbekistan': 'UZ',
      'Vanuatu': 'VU',
      'Vatican City': 'VA',
      'Venezuela': 'VE',
      'Vietnam': 'VN',
      'Yemen': 'YE',
      'Zambia': 'ZM',
      'Zimbabwe': 'ZW',
    };
    String cleanCountryName = countryName
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .trim();
    String formattedCity = city.trim();

    String? countryCode = countryCodes[cleanCountryName];

    String formatApi =
        "https://api.openweathermap.org/data/2.5/weather?q=$formattedCity,$countryCode&appid=$apiKey";

    try {
      NetworkHelper networkHelper = NetworkHelper(formatApi);
      Map<String, dynamic> weatherData = await networkHelper.getDataByCountry();

      country = weatherData["sys"]["country"].toString();
      city = weatherData["name"].toString();
      temp = weatherData["main"]["temp"].toDouble().toStringAsFixed(0);
      weatherState = weatherData["weather"][0]["main"].toString();
      wind = weatherData["wind"]["speed"].toString();
      humidity = weatherData["main"]["humidity"].toString();
      clouds = weatherData["clouds"]["all"].toString();
      weatherStateImg = weatherData["weather"][0]["icon"];

      return weatherData;
    } catch (e) {
      return Future.error("Error Fetching Weather Data: $e");
    }
  }

  String getWeatherImage(int weatherCode) {
    if (weatherCode <= 232) {
      return "storm";
    } else if (weatherCode <= 531) {
      return "rainy";
    } else if (weatherCode <= 622) {
      return "sun";
    } else if (weatherCode >= 801 && weatherCode <= 804) {
      return "cloudy";
    } else {
      return "weather";
    }
  }
}
