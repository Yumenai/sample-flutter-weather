import 'weather_model.dart';

class DailyWeatherModel {
  final DateTime? dateTime;
  final List<WeatherModel> weatherModelList;

  const DailyWeatherModel({
    required this.dateTime,
    required this.weatherModelList,
  });
}