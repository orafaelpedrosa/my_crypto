import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/pages/widget/crypto_list_widget.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';
import 'package:mycrypto/app/shared/widgets/error/error_type_widget.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    CryptoListStore store = Modular.get();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/app/mycrypto.svg',
            color: Theme.of(context).primaryColor,
            height: 25,
            width: 25,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: TripleBuilder<CryptoListStore, DioError, List<CryptocurrencyModel>>(
        store: store,
        builder: (_, triple) {
          if (store.isLoading) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          } else if (triple.event == TripleEvent.error) {
            log('Error: ${triple.error!.response!.statusCode}');
            return ErrorHttpWidget(
              error: triple.error!.response!.statusCode.toString(),
            );
          } else {
            return CryptocurrencyListWidget();
          }
        },
      ),
    );
  }
}
