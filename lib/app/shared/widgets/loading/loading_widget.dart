import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final bool isStretch;
  final Color color;

  LoadingWidget({
    Key? key,
    this.isStretch = true,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: color,
          child: Column(
            crossAxisAlignment: isStretch
                ? CrossAxisAlignment.stretch
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Lottie.asset(
                    'assets/app/loading.json',
                    width: 150,
                    height: 150,
                    
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
