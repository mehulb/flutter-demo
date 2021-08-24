import 'package:apis_app/pages/country_details.dart';
import 'package:flutter/material.dart';
import 'package:apis_app/pages/home.dart';
import 'package:apis_app/pages/countries_list.dart';
import 'package:apis_app/pages/currencies_list.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/home",
    routes: {
      "/home": (context) => Home(),
      "/countries": (context) => CountriesList(),
      "/country_details": (context) => CountryDetails(),
      "/currencies": (context) => CurrenciesList(),
    },
  ));
}