import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;

  LoadingWidget({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color == Theme.of(context).colorScheme.primary
          ? Theme.of(context).colorScheme.background
          : color,
      child: Center(
        child: CircularProgressIndicator(
          color: color != Theme.of(context).colorScheme.primary
              ? Theme.of(context).colorScheme.primary
              : color,
        ),
      ),
    );
  }
}
