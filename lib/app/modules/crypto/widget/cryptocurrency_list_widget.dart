import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/core/theme/colors.dart';
import 'package:mycrypto/app/modules/crypto/stores/cryptocurrency_store.dart';
import 'package:mycrypto/app/modules/crypto/widget/cryptocurrency_card_widget.dart';

class CryptocurrencyListWidget extends StatefulWidget {
  const CryptocurrencyListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CryptocurrencyListWidgetState createState() =>
      _CryptocurrencyListWidgetState();
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
    return TripleBuilder<CryptocurrencyStore, Exception,
        List<CryptocurrencyModel>>(
      store: store,
      builder: (_, context) {
        if (store.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return StreamBuilder<List<CryptocurrencyModel>>(
            stream: Stream.periodic(
              const Duration(seconds: 4),
              (_) {
                store.getCrypto();
                return store.state;
              },
            ),
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.data!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.separated(
                  itemCount: store.state.length,
                  itemBuilder: (_, index) {
                    final cryptocurrency = store.state[index];
                    return CryptocurrencyCardWidget(
                      crypto_name: cryptocurrency.name,
                      crypto_symbol: cryptocurrency.symbol,
                      crypto_price: double.parse(cryptocurrency.price!),
                      crypto_rank: cryptocurrency.rank,
                      crypto_logo_url: cryptocurrency.logoUrl,
                      imageFormat: getImageFormat(cryptocurrency.logoUrl),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(
                    height: 0.75,
                    color: AppColors.secondaryColor.withOpacity(0.25),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  String getImageFormat(String? url) {
    if (url == null) {
      return 'null';
    } else {
      String imageFormat = '';
      int indexPoint = url.length;
      imageFormat = url.substring(indexPoint - 3);
      return imageFormat;
    }
  }
}
