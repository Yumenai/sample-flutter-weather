import 'package:flutter/material.dart';

import '../component/item/weather_item_component.dart';
import '../model/forecast_model.dart';
import '../model/weather_model.dart';
import '../service/repository_service.dart';
import '../utility/navigator_utility.dart';
import 'weather_page_route.dart';

class HomeScreenRoute extends StatefulWidget {
  static void navigate(final BuildContext context, {
    final ForecastModel? forecastModel,
  }) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: HomeScreenRoute(
        previousForecastModel: forecastModel,
      ),
    );
  }

  final ForecastModel? previousForecastModel;

  const HomeScreenRoute({
    Key? key,
    required this.previousForecastModel,
  }) : super(key: key);

  @override
  State<HomeScreenRoute> createState() => _HomeScreenRouteState();
}

class _HomeScreenRouteState extends State<HomeScreenRoute> {
  late final _listNotification = _ListNotification(widget.previousForecastModel);
  final _weatherNotifier = _HomeNotification();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_weatherNotifier._weatherModel == null) {
          return true;
        }

        _weatherNotifier.clear();

        return false;
      },
      child: LayoutBuilder(
        builder: (context, boxConstraint) {
          if (boxConstraint.constrainWidth() < 400) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Weather Forecast'),
                centerTitle: true,
                leading: AnimatedBuilder(
                  animation: _weatherNotifier,
                  builder: (context, widget) {
                    if (_weatherNotifier._weatherModel == null) {
                      return const SizedBox();
                    } else {
                      return IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Close',
                        onPressed: () => _weatherNotifier.clear(),
                      );
                    }
                  },
                ),
              ),
              body: _layoutPortrait,
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Weather Forecast'),
                centerTitle: true,
              ),
              body: _layoutLandscape,
            );
          }
        },
      ),
    );
  }

  Future<void> loadData() async {
    _listNotification.add(await RepositoryService.network.getWeatherForecast(
      context,
      responseCallback: (response) async {
        if (response != null) await RepositoryService.file.setPastWeatherJson(response);
      },
    ));
  }

  Widget get _layoutPortrait {
    return Stack(
      children: [
        _weatherForecastList,
        AnimatedBuilder(
          animation: _weatherNotifier,
          builder: (context, widget) {
            return AnimatedOpacity(
              duration: const Duration(
                milliseconds: 250,
              ),
              opacity: _weatherNotifier._weatherModel == null ? 0 : 1,
              child: _weatherNotifier._weatherModel == null ? const SizedBox() : WeatherPageRoute(
                model: _weatherNotifier._weatherModel!,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget get _layoutLandscape {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _weatherForecastList,
        ),
        Expanded(
          flex: 2,
          child: AnimatedBuilder(
            animation: _weatherNotifier,
            builder: (context, widget) {
              return _weatherNotifier._weatherModel == null ? const SizedBox() : WeatherPageRoute(
                model: _weatherNotifier._weatherModel!,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget get _weatherForecastList {
    return AnimatedBuilder(
      animation: _listNotification,
      builder: (context, widget) {
        return AnimatedOpacity(
          opacity: _listNotification.forecastModel == null ? 0 : 1,
          duration: const Duration(milliseconds: 250),
          child: _listNotification.forecastModel == null ? const SizedBox() : RefreshIndicator(
            onRefresh: () async => loadData(),
            child: ListView.builder(
              itemCount: _listNotification.forecastModel?.weatherCalenderModelList.length ?? 0,
              itemBuilder: (context, position) {
                return WeatherItemComponent(
                  key: UniqueKey(),
                  model: _listNotification.forecastModel?.weatherCalenderModelList[position],
                  onTap: (model) => _weatherNotifier.select(model),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ListNotification extends ChangeNotifier {
  ForecastModel? forecastModel;

  _ListNotification(this.forecastModel);

  void add(final ForecastModel? model) {
    if (model == null) return;

    forecastModel = model;
    notifyListeners();
  }
}

class _HomeNotification extends ChangeNotifier {
  WeatherModel? _weatherModel;

  void select(final WeatherModel model) {
    if (_weatherModel == model) {
      clear();
    } else {
      _weatherModel = model;
      notifyListeners();
    }
  }

  void clear() {
    _weatherModel = null;
    notifyListeners();
  }
}
