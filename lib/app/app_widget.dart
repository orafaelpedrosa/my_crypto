import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/theme/theme.dart';


class AppWidget extends StatelessWidget {


  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'myCrypto',
        theme: theme,
      ).modular();
  }
}
