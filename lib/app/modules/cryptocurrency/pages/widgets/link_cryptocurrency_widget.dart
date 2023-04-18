import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCryptocurrencyWidget extends StatelessWidget {
  final String? title;
  final String? url;
  LinkCryptocurrencyWidget({
    Key? key,
    this.title,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.link_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(width: 5),
            Text(
              '${title!} ',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            await launchUrl(Uri.parse(url!));
          },
          child: Text(
            url!,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                ),
          ),
        ),
      ],
    );
  }
}
