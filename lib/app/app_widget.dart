import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/stores/theme_mode_store.dart';
import 'package:mycrypto/app/core/theme/app_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  final ThemeModeStore store = Modular.get();

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

  Future<void> didChangePlatformBrightness() async {
    super.didChangePlatformBrightness();
    final themeMode = await store.getThemeMode();
    if (themeMode == ThemeMode.system) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      if (brightness == Brightness.dark) {
        store.updateState(ThemeMode.dark);
      } else {
        store.updateState(ThemeMode.light);
      }
    } else {
      store.updateState(themeMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    store.updateState(store.state);
    return TripleBuilder(
      store: store,
      builder: (context, triple) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: store.state,
          supportedLocales: const [Locale('pt', 'BR')],
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        );
      },
    );
  }
}
