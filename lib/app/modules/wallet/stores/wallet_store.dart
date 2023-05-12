import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/price_simple_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

// ignore: must_be_immutable
class WalletStore extends Store<List<MyCryptoModel>> {
  WalletStore() : super([]);

  final WalletRepository _repository = WalletRepository();

  PriceSimpleModel price = PriceSimpleModel();
  List<CoinSearchModel> listSearch = List.empty(growable: true);
  List<CryptocurrencySimpleModel> coinsList = List.empty(growable: true);
  MyCryptoModel cryptoModel = MyCryptoModel();
  DateTime date = DateTime.now();

  Future<void> updateState() async {
    update(state, force: true);
  }

  Future<void> addCryptocurrency(MyCryptoModel crypto) async {
    setLoading(true);
    await _repository.addCrypto(crypto).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> removeCryptocurrency(MyCryptoModel crypto) async {
    setLoading(true);
    await _repository.removeCryptocurrency(crypto).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> updateCryptocurrency(MyCryptoModel crypto) async {
    setLoading(true);
    await _repository.updateCryptocurrency(crypto).then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> updatePrice() async {
    setLoading(true);
    await _repository.updatePrice().then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> getAllWalletCoins() async {
    setLoading(true);
    await _repository.getAllWalletCoins().then((value) {
      update(value);
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  Future<void> totalValue() async {
    setLoading(true);
    await _repository.updateTotalWallet().then((value) {
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
    setLoading(false);
  }

  Future<void> getSearchCoin(String text) async {
    setLoading(true);
    await _repository.getSearchCoin(text).then((value) {
      listSearch = value;
      setLoading(false);
    }).catchError(
      (e) {
        setLoading(false);
        setError(e);
      },
    );
  }

  Future<void> getSimplePriceID(String id) async {
    setLoading(true);
    await _repository.getSimplePriceID(id).then((value) {
      cryptoModel.currentPrice = value.usd;
      update(state, force: true);
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<void> getListCryptocurrenciesData(
      MarketsParamsModel paramsModel) async {
    setLoading(true);
    paramsModel.ids = await _repository.getListOfWalletIDs();
    await _repository.getListCryptocurrenciesData(paramsModel).then((value) {
      coinsList = value;
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
  }

  Future<double> getPriceDolarInBRL() async {
    setLoading(true);
    double priceDolar = 1;
    await _repository.getPriceDolarInBRL().then((value) {
      cryptoModel.currentPrice =
          (cryptoModel.currentPrice! * double.parse(value.ask!));
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
      throw e;
    });
    return priceDolar;
  }
}
