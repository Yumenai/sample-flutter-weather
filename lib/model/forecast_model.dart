import 'location_model.dart';
import 'daily_weather_model.dart';
import 'weather_model.dart';

class ForecastModel {
  static ForecastModel? fromNetwork(final Map? dataMap) {
    if (dataMap == null) return null;

    final modelList = WeatherModel.fromNetworkList(dataMap['list']);

    final weatherCalenderModelList = <DailyWeatherModel> [];

    for (final model in modelList) {
      if (weatherCalenderModelList.isEmpty) {
        weatherCalenderModelList.add(DailyWeatherModel(
          dateTime: model.dateTime,
          weatherModelList: [model],
        ));
      } else {
        bool isAbsent = true;
        for (final calender in weatherCalenderModelList) {
          if (calender.dateTime?.year == model.dateTime?.year) {
            if (calender.dateTime?.month == model.dateTime?.month) {
              if (calender.dateTime?.day == model.dateTime?.day) {
                calender.weatherModelList.add(model);
                isAbsent = false;
                break;
              }
            }
          }
        }

        if (isAbsent) {
          weatherCalenderModelList.add(DailyWeatherModel(
            dateTime: model.dateTime,
            weatherModelList: [model],
          ));
        }
      }
    }

    return ForecastModel(
      locationModel: LocationModel.fromNetwork(dataMap['city']),
      weatherCalenderModelList: weatherCalenderModelList,
    );
  }

  final LocationModel? locationModel;
  final List<DailyWeatherModel> weatherCalenderModelList;

  const ForecastModel({
    required this.locationModel,
    required this.weatherCalenderModelList,
  });
}