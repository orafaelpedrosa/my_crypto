import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/theme/theme.dart';
import 'package:mycrypto/app/modules/home/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        Modular.get<MyNavigatorObserver>(),
      ],
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      theme: theme,
    ).modular();
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>?> routeStack = List.empty(growable: true);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.add(route);
    log('didPush: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    log('didPop: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    log('didRemove: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    routeStack.removeLast();
    routeStack.add(newRoute);
    log('didReplace: ${routeStack.map((route) => route?.settings.name)}');
  }
}
