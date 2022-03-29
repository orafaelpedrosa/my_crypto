import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycrypto/app/modules/crypto/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_store.dart';
import 'package:mycrypto/app/modules/crypto/widget/cryptocurrency_card_widget.dart';

class CryptocurrencyListWidget extends StatefulWidget {
  const CryptocurrencyListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CryptocurrencyListWidgetState createState() => _CryptocurrencyListWidgetState();
}

class _CryptocurrencyListWidgetState extends State<CryptocurrencyListWidget> {
  CryptocurrencyStore store = Modular.get();
  CryptocurrencyRepository repository = Modular.get();

  @override
  void initState() {
    store.getCrypto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CryptocurrencyModel>>(
      stream: Stream.periodic(
        const Duration(seconds: 10),
        (_) {
          store.getCrypto();
          return store.state;
        },
      ),
      initialData: const [],
      builder: (context, snapshot) {
        return ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: snapshot.data!
              .map<Widget>(
                (crypto) => CryptocurrencyCardWidget(
                  crypto_name: crypto.name,
                  crypto_price: double.parse(crypto.price!),
                  crypto_symbol: crypto.symbol,
                  crypto_rank: crypto.rank,
                  crypto_logo_url: crypto.logoUrl,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
