import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';

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
  CryptocurrencyDataStore store = Modular.get();

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
        child: TripleBuilder<CryptocurrencyDataStore, DioError,
            CryptocurrencyDetailsModel>(
          store: store,
          builder: (_, triple) {
            if (store.isLoading) {
              return CircularProgressIndicator();
            } else {
              return Text('${store.state.name}');
            }
          },
        ),
      ),
    );
  }
}
