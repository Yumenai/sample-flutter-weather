import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/forecast_model.dart';
import '../service/repository_service.dart';
import 'home_screen_route.dart';

class SplashScreenRoute extends StatefulWidget {
  const SplashScreenRoute({Key? key}) : super(key: key);

  @override
  State<SplashScreenRoute> createState() => _SplashScreenRouteState();
}

class _SplashScreenRouteState extends State<SplashScreenRoute> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final data = await RepositoryService.file.getPastWeatherJson();

      ForecastModel? model;
      if (data.isNotEmpty) {

        model = ForecastModel.fromNetwork(jsonDecode(data));
      }

      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) {
        HomeScreenRoute.navigate(
          context,
          forecastModel: model,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Weather Forecast'),
      ),
    );
  }
}
