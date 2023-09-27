//store
import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/wallet/models/market_chart_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

// ignore: must_be_immutable
class CoinDataStore extends Store<CryptocurrencyDetailsModel> {
  CoinDataStore() : super(CryptocurrencyDetailsModel());

  final WalletRepository _repository = WalletRepository();
  CryptoData cryptoData = CryptoData();

  Future<void> getMarketChart(String id) async {
    setLoading(true);
    await _repository.getMarketChart(id).then((value) {
      setLoading(false);
      cryptoData = value;
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }
}
