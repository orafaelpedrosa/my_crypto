import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_repository.dart';

// ignore: must_be_immutable
class SearchStore extends NotifierStore<Exception, SearchModel>
    with Disposable {
  SearchStore() : super(SearchModel());

  final WalletRepository _repository = WalletRepository();
  Timer? _debounce;

  Future<void> getSearchCoin(String text) async {
    if (_debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        setLoading(true);
        await _repository.getSearchCoin(text).then((value) {
          update(value);
          setLoading(false);
        }).catchError(
          (e) {
            setLoading(false);
            setError(e);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce!.cancel();
  }
}
