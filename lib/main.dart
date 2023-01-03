import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/weather_search_page.dart';

import 'data/weather_repository.dart';
import 'domain/weather_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Search',
      debugShowCheckedModeBanner: false,
      home: Provider(
          create: (context) => WeatherStore(repo: FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}
