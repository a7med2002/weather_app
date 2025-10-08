import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({super.key});

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SelectState(
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                  print("selected Country: $countryValue");
                  print("selected State: $stateValue");
                  print("selected City: $cityValue");
                  Navigator.pop(context, {
                    'country': countryValue,
                    'state': stateValue,
                    'city': cityValue,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
