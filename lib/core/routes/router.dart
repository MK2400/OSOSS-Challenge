
import 'package:flutter/material.dart';
import 'package:ososs/core/resources/app_strings.dart';
import 'package:ososs/core/routes/routes.dart';
import 'package:ososs/features/animations/views/animations_view.dart';
import 'package:ososs/features/home/views/home_view.dart';
import 'package:ososs/features/splash_screen/views/splash_view.dart';

class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final Map arguments = (settings.arguments ?? {}) as Map;
    switch (settings.name) {
      case AppRoutes.splashScreen:
        {
          return MaterialPageRoute(builder: (_) => const SplashView());
        }

      case AppRoutes.homeScreen:
        {
          return MaterialPageRoute(builder: (_) => const HomeView());
        }

      case AppRoutes.animationsScreen:
        {
          return MaterialPageRoute(builder: (_) =>  AnimationsView(name: arguments['name']));
        }
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('${AppStrings.noRouteFound}${settings.name}.')),
                ));
    }
  }
}
