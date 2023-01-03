// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WeatherStore on _WeatherStore, Store {
  Computed<WeatherStatus>? _$statusComputed;

  @override
  WeatherStatus get status =>
      (_$statusComputed ??= Computed<WeatherStatus>(() => super.status,
              name: '_WeatherStore.status'))
          .value;

  late final _$_weatherFutureAtom =
      Atom(name: '_WeatherStore._weatherFuture', context: context);

  @override
  ObservableFuture<Weather>? get _weatherFuture {
    _$_weatherFutureAtom.reportRead();
    return super._weatherFuture;
  }

  @override
  set _weatherFuture(ObservableFuture<Weather>? value) {
    _$_weatherFutureAtom.reportWrite(value, super._weatherFuture, () {
      super._weatherFuture = value;
    });
  }

  late final _$weatherAtom =
      Atom(name: '_WeatherStore.weather', context: context);

  @override
  Weather? get weather {
    _$weatherAtom.reportRead();
    return super.weather;
  }

  @override
  set weather(Weather? value) {
    _$weatherAtom.reportWrite(value, super.weather, () {
      super.weather = value;
    });
  }

  late final _$errMessageAtom =
      Atom(name: '_WeatherStore.errMessage', context: context);

  @override
  String? get errMessage {
    _$errMessageAtom.reportRead();
    return super.errMessage;
  }

  @override
  set errMessage(String? value) {
    _$errMessageAtom.reportWrite(value, super.errMessage, () {
      super.errMessage = value;
    });
  }

  late final _$loadWeatherAsyncAction =
      AsyncAction('_WeatherStore.loadWeather', context: context);

  @override
  Future<dynamic> loadWeather(String cityName) {
    return _$loadWeatherAsyncAction.run(() => super.loadWeather(cityName));
  }

  @override
  String toString() {
    return '''
weather: ${weather},
errMessage: ${errMessage},
status: ${status}
    ''';
  }
}
