import 'package:flutter/material.dart';

import '../component/view/image_view_component.dart';
import '../data/configuration_data.dart';
import '../model/weather_model.dart';
import '../utility/format_utility.dart';

class WeatherPageRoute extends StatelessWidget {
  final WeatherModel model;

  const WeatherPageRoute({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        children: [
          Center(
            child: ImageViewComponent.network(
              ConfigurationData.getWeatherIconUrl(model.weatherIcon),
              width: 100,
              height: 100,
            ),
          ),
          Text(
            model.weatherName.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            FormatUtility.time(model.dateTime?.toUtc()),
            textAlign: TextAlign.center,
            style: const TextStyle(
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Divider(),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: _InfoText(
                    title: 'Wind: ',
                    content: model.windSpeed,
                    enableSpacing: false,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InfoText(
                      title: 'Current: ',
                      content: '${FormatUtility.temperatureFahrenheitToCelsius(model.temperatureCurrent).toStringAsFixed(2)} °C',
                    ),
                    _InfoText(
                      title: 'Max: ',
                      content: '${FormatUtility.temperatureFahrenheitToCelsius(model.temperatureMaximum).toStringAsFixed(2)} °C',
                    ),
                    _InfoText(
                      title: 'Min: ',
                      content: '${FormatUtility.temperatureFahrenheitToCelsius(model.temperatureMinimum).toStringAsFixed(2)} °C',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String title;
  final String content;
  final bool enableSpacing;

  const _InfoText({
    Key? key,
    required this.title,
    required this.content,
    this.enableSpacing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: enableSpacing ? 2 : 1,
          child: Text(
            content,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

