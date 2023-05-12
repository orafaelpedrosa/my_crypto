import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/theme/app_theme.dart';
import 'package:mycrypto/app/core/stores/theme_mode_store.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  final ThemeModeStore _themeModeStore = Modular.get();

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
    final themeMode = await _themeModeStore.getThemeMode();
    if (themeMode == ThemeMode.system) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      if (brightness == Brightness.dark) {
        _themeModeStore.updateState(ThemeMode.dark);
      } else {
        _themeModeStore.updateState(ThemeMode.light);
      }
    } else {
      _themeModeStore.updateState(themeMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    _themeModeStore.updateState(_themeModeStore.state);
    return TripleBuilder(
      store: _themeModeStore,
      builder: (context, triple) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeModeStore.state,
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
