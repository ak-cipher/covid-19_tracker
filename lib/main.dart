import 'package:covid_19_tracker/View/splash_screen.dart';
import 'package:flutter/material.dart';

import 'View/countries_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      routes: {'/CountryListScreen': ((context) => CountriesListScreen())},
      home: const SplashScreen(),
    );
  }
}
