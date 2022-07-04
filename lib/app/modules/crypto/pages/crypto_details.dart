import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/core/theme/theme.dart';
import 'package:mycrypto/app/modules/crypto/pages/widget/crypto_logo_widget.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_store.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptocurrencyModel cryptoModel;
  const CryptoDetailsPage({
    required this.cryptoModel,
    Key? key,
  }) : super(key: key);

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState
    extends State<CryptoDetailsPage> {
  final CryptoStore _store = Modular.get();

  @override
  void initState() {
    _store.state.id = widget.cryptoModel.id;
    _store.getCryptoData();
    super.initState();
  }

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
            logoFormat: _store.state.logoFormat,
            logoUrl: _store.state.logoUrl,
            width: 30,
            height: 30,
          ),
          SizedBox(width: 5),
          Text(
            _store.state.symbol!,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black87,
                ),
          ),
          SizedBox(width: 5),
          _store.state.priceDay!.priceChangePct!.contains('-')
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
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_sharp,
          color: theme.primaryColor,
        ),
        onPressed: () {
          _store.state.id = null;
          Modular.to.pop();
        },
      ),
    );
  }

  Widget get cryptoDetailsBody {
    return TripleBuilder<CryptoStore, Exception, CryptocurrencyModel>(
      store: _store,
      builder: (_, triple) {
        return Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                triple.state.name!,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.black87,
                    ),
              ),
              Text(
                _store.state.price!,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
