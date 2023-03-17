import 'package:flutter/material.dart';

import '../../data/configuration_data.dart';
import '../../model/daily_weather_model.dart';
import '../../model/weather_model.dart';
import '../../utility/format_utility.dart';
import '../view/image_view_component.dart';

class WeatherItemComponent extends StatelessWidget {
  final DailyWeatherModel? model;
  final void Function(WeatherModel) onTap;

  const WeatherItemComponent({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = this.model;

    if (model == null) return const SizedBox();

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: InkWell(
        onTap: () => onTap(model.weatherModelList.first),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                FormatUtility.dateName(model.dateTime?.toUtc()),
                textAlign: TextAlign.right,
              ),
              Row(
                children: [
                  ImageViewComponent.network(
                    ConfigurationData.getWeatherIconUrl(model.weatherModelList.first.weatherIcon),
                    width: 100,
                    height: 100,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          model.weatherModelList.first.weatherName.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Text(FormatUtility.time(model.weatherModelList.first.dateTime?.toUtc())),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 75,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.weatherModelList.length,
                  itemBuilder: (context, position) {
                    if (position == 0) return const SizedBox();

                    return _WeatherItem(
                      model: model.weatherModelList[position],
                      onTap: () => onTap(model.weatherModelList[position]),
                    );
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherItem extends StatelessWidget {
  final WeatherModel model;
  final void Function() onTap;

  const _WeatherItem({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: ImageViewComponent.network(
                ConfigurationData.getWeatherIconUrl(model.weatherIcon),
                width: 75,
                height: 75,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Text(
              FormatUtility.time(model.dateTime?.toUtc()),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
