import 'package:flutter/cupertino.dart';

class ConfigurationData {
  static const weatherForecastHostAddress = 'https://samples.openweathermap.org';

  static String getWeatherIconUrl(final String name) {
    return 'https://openweathermap.org/img/wn/$name@2x.png';
  }

  const ConfigurationData._();
}
