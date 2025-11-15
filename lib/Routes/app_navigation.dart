import 'package:ekvi/Routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get currentContext =>
      navigatorKey.currentState?.overlay?.context;

  static goBack() {
    return navigatorKey.currentState!.pop();
  }

  static bool canGoback() {
    return navigatorKey.currentState!.canPop();
  }

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil((route) {
      return route.settings.name == routeName;
    });
  }

  static void popUntilAndNavigateTo(String popUntilRouteName, String navigateToRouteName, {Object? arguments}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        navigateToRouteName, ModalRoute.withName(popUntilRouteName),
        arguments: arguments);
  }

  static Future<dynamic> pushAndKillAll(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(AppRoutes.initial));
  }

  static Future<dynamic> pushReplacementTo(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}
