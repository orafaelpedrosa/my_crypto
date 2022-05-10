import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/core/theme/theme.dart';
import 'package:mycrypto/app/modules/crypto/stores/list_crypto_store.dart';
import 'package:mycrypto/app/modules/crypto/widget/crypto_logo_widget.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptocurrencyModel cryptoModel;
  const CryptoDetailsPage({
    Key? key,
    required this.cryptoModel,
  }) : super(key: key);

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState
    extends ModularState<CryptoDetailsPage, CryptoListStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCryptoDetails,
      backgroundColor: Colors.white,
      body: cryptoDetailsBody,
    );
  }

  PreferredSizeWidget get appBarCryptoDetails {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CryptoLogoWidget(
            logoFormat: widget.cryptoModel.logoFormat,
            logoUrl: widget.cryptoModel.logoUrl,
            width: 30,
            height: 30,
          ),
          SizedBox(width: 5),
          Text(
            widget.cryptoModel.symbol!,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black87,
                ),
          ),
          SizedBox(width: 5),
          widget.cryptoModel.priceDay!.priceChangePct!.contains('-')
              ? Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.red,
                  size: 35,
                )
              : Icon(
                  Icons.arrow_drop_up_sharp,
                  color: Colors.green,
                  size: 35,
                ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      actions: [
        IconButton(
          onPressed: () {
            log('Favorite');
          },
          icon: Icon(
            Icons.star_border_rounded,
            color: theme.primaryColor,
            size: 30,
          ),
        ),
      ],
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget get cryptoDetailsBody {
    return TripleBuilder<CryptoListStore, Exception, List<CryptocurrencyModel>>(
      store: store,
      builder: (_, triple) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                widget.cryptoModel.price!,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
