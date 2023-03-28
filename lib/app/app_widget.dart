import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/enums/theme_type_enum.dart';
import 'package:mycrypto/app/core/services/theme_manager.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  final ThemeManager _themeManager = ThemeManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    super.didChangePlatformBrightness();
    final ThemeModeEnum themeMode = await _themeManager.getThemeType();
    await _themeManager.setThemeType(themeMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: _themeManager.themeData,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
      locale: Locale('pt', 'BR'),
    );
  }
}
