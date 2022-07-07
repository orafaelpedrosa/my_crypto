import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';

class CryptocurrencyItemListWidget extends StatefulWidget {
  final CryptocurrencySimpleModel coin;
  CryptocurrencyItemListWidget({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  State<CryptocurrencyItemListWidget> createState() =>
      _CryptocurrencyItemListWidgetState();
}

class _CryptocurrencyItemListWidgetState
    extends State<CryptocurrencyItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.coin.name!,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
