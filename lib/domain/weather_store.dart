import 'package:mobx/mobx.dart';

import '../data/model/weather.dart';
import '../data/weather_repository.dart';

part 'weather_store.g.dart';

class WeatherStore = _WeatherStore with _$WeatherStore;

enum WeatherStatus {
  initial,
  loading,
  loaded,
}

abstract class _WeatherStore with Store {
  final WeatherRepository repo;
  _WeatherStore({required this.repo});

  @observable
  ObservableFuture<Weather>? _weatherFuture;
  @observable
  Weather? weather;

  @observable
  String? errMessage;

  @computed
  WeatherStatus get status {
    if (_weatherFuture == null ||
        _weatherFuture?.status == FutureStatus.rejected) {
      return WeatherStatus.initial;
    }
    return _weatherFuture?.status == FutureStatus.pending
        ? WeatherStatus.loading
        : WeatherStatus.loaded;
  }

  @action
  Future loadWeather(String cityName) async{
    try{
      errMessage = null;
      _weatherFuture = ObservableFuture(repo.fetchWeather(cityName));
      weather = await _weatherFuture;
    }on NetworkError{
      errMessage = "Is this device online??";
    }
  }
}
