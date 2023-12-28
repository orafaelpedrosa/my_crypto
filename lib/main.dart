import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
}
