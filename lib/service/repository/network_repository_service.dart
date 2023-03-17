import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/configuration_data.dart';
import '../../model/forecast_model.dart';
import '../../utility/network_utility.dart';

class NetworkRepositoryService {
  const NetworkRepositoryService();

  Future<ForecastModel?> getWeatherForecast(final BuildContext context, {
    final void Function(String? response)? responseCallback,
  }) async {
    final result = await NetworkUtility.get(
      hostAddress: ConfigurationData.weatherForecastHostAddress,
      apiRoute: '/data/2.5/forecast?id=524901&appid=b6907d289e10d714a6e88b30761fae22',
    );

    responseCallback?.call(result?.body);

    if (NetworkUtility.isSuccess(result)) {
      return ForecastModel.fromNetwork(jsonDecode(result?.body ?? '{}'));
    }

    return null;
  }
}