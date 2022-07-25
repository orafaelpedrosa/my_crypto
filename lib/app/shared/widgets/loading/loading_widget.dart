import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;

  LoadingWidget({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color == Theme.of(context).primaryColor
          ? Colors.white
          : color,
      child: Center(
        child: CircularProgressIndicator(
          color: color != Theme.of(context).primaryColor
              ? Theme.of(context).primaryColor
              : color,
        ),
      ),
    );
  }
}
