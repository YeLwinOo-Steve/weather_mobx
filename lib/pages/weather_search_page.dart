import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../data/model/weather.dart';
import '../domain/weather_store.dart';

class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  WeatherStore? _weatherStore;
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _weatherStore ??= Provider.of<WeatherStore>(context,listen: false);
    _disposers ??= [
      reaction((_) => _weatherStore?.errMessage, (String? message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$message')));
      }),
    ];
  }

  @override
  void dispose() {
    _disposers?.forEach((d) => d.call());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Observer(
          builder: (_) {
            switch (_weatherStore?.status) {
              case WeatherStatus.initial:
                return buildInitialInput();
              case WeatherStatus.loading:
                return buildLoading();
              case WeatherStatus.loaded:
                Weather? weather = _weatherStore?.weather;
                return buildColumnWithData(weather!);
              default:
                return const Center(
                  child: Text('Something went wrong!'),
                );
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: const TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherStore = Provider.of<WeatherStore>(context,listen: false);
    weatherStore.loadWeather(cityName);
  }
}
