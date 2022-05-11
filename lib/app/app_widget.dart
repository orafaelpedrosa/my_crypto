import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/theme/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      /*navigatorObservers: [
        Modular.get<MyNavigatorObserver>(),
      ],*/
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      theme: theme,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}

/*class MyNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>?> routeStack = List.empty(growable: true);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.add(route);
    print('didPush: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    print('didPop: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    print('didRemove: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    routeStack.removeLast();
    routeStack.add(newRoute);
    print('didReplace: ${routeStack.map((route) => route?.settings.name)}');
  }
}*/
