class WeatherModel {
  static WeatherModel? fromNetwork(final Map? dataMap) {
    if (dataMap == null) return null;

    return WeatherModel(
      temperatureCurrent: double.tryParse(dataMap['main']?['temp']?.toString() ?? '') ?? 0,
      temperatureMaximum: double.tryParse(dataMap['main']?['temp_max']?.toString() ?? '') ?? 0,
      temperatureMinimum: double.tryParse(dataMap['main']?['temp_min']?.toString() ?? '') ?? 0,
      weatherId: dataMap['weather']?[0]?['id']?.toString() ?? '',
      weatherIcon: dataMap['weather']?[0]?['icon']?.toString() ?? '',
      weatherName: dataMap['weather']?[0]?['main']?.toString() ?? '',
      weatherDescription: dataMap['weather']?[0]?['description']?.toString() ?? '',
      dateTime: DateTime.tryParse(dataMap['dt_txt']?.toString() ?? ''),
      windSpeed: dataMap['wind']?['speed']?.toString() ?? '',
    );
  }

  static List<WeatherModel> fromNetworkList(final dynamic dataList) {
    final modelList = <WeatherModel> [];

    if (dataList is List) {
      for (final data in dataList) {
        final model = fromNetwork(data);

        if (model != null) {
          modelList.add(model);
        }
      }
    }

    return modelList;
  }

  final double temperatureCurrent;
  final double temperatureMaximum;
  final double temperatureMinimum;
  final String weatherId;
  final String weatherIcon;
  final String weatherName;
  final String weatherDescription;
  final String windSpeed;

  final DateTime? dateTime;

  const WeatherModel({
    required this.temperatureCurrent,
    required this.temperatureMaximum,
    required this.temperatureMinimum,
    required this.weatherId,
    required this.weatherIcon,
    required this.weatherName,
    required this.weatherDescription,
    required this.dateTime,
    required this.windSpeed,
  });
}
