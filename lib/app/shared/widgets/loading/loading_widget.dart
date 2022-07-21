import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;

  LoadingWidget({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Lottie.asset(
        'assets/app/load.json',
        width: 50,
        height: 50,
      ),
    );
  }
}
