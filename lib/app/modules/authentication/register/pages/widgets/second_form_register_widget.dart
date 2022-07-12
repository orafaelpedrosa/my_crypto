import 'package:flutter/material.dart';

class SecondFormRegisterWidget extends StatefulWidget {
  final PageController pageController;
  const SecondFormRegisterWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<SecondFormRegisterWidget> createState() =>
      _SecondFormRegisterWidgetState();
}

class _SecondFormRegisterWidgetState extends State<SecondFormRegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Segunda',
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
