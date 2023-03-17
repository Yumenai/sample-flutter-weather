import 'package:flutter/material.dart';

import 'route/splash_screen_route.dart';

void main() {
  runApp(
    MaterialApp(
      home: const SplashScreenRoute(),
      theme: ThemeData(
        useMaterial3: true,
      ),
    ),
  );
}
