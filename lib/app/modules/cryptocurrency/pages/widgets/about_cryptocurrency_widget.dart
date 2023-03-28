import 'package:flutter/material.dart';
import 'package:mycrypto/app/shared/widgets/read_more_text.dart';

class AboutCryptocurrencyWidget extends StatefulWidget {
  final String about;
  const AboutCryptocurrencyWidget({
    Key? key,
    required this.about,
  }) : super(key: key);

  @override
  State<AboutCryptocurrencyWidget> createState() =>
      _AboutCryptocurrencyWidgetState();
}

class _AboutCryptocurrencyWidgetState extends State<AboutCryptocurrencyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sobre',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 10),
        ReadMoreText(
          widget.about,
          trimLines: 5,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
          colorClickableText: Theme.of(context).colorScheme.primary,
          trimMode: TrimMode.Line,
          textAlign: TextAlign.justify,
        )
      ],
    );
  }
}
