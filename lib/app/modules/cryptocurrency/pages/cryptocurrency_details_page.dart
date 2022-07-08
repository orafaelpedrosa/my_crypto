import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';

class CryptocurrencyDetailsPage extends StatefulWidget {
  final String id;
  const CryptocurrencyDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CryptocurrencyDetailsPage> createState() =>
      _CryptocurrencyDetailsPageState();
}

class _CryptocurrencyDetailsPageState extends State<CryptocurrencyDetailsPage> {
  ListCryptocurrenciesStore store = Modular.get();

    @override
  void initState() {
    store.getCryptocurrencyById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('CryptocurrencyDetailsPage ${widget.id}');
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.id}'),
      ),
      body: Center(
        child: Text('Detail'),
      ),
    );
  }
}
