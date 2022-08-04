import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_model.dart';

import 'package:mycrypto/app/modules/cryptocurrency/stores/chart_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';

class TabPriceChangePercentageWidget extends StatefulWidget {
  TabPriceChangePercentageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TabPriceChangePercentageWidget> createState() =>
      _TabPriceChangePercentageWidgetState();
}

class _TabPriceChangePercentageWidgetState
    extends State<TabPriceChangePercentageWidget> {
  final ChartStore _store = Modular.get();
  final CryptocurrencyDataStore _dataStore = Modular.get();
  Utils _utils = Utils();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ChartStore, Exception, ChartModel>(
      store: _store,
      builder: (_, triplo) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _dataStore.state.priceChangePercente! > 0
                ? Colors.green
                : Colors.red,
          ),
          child: Text(
            _dataStore.state.priceChangePercente!.isNegative
                ? '${_utils.formatNumber(_dataStore.state.priceChangePercente!)}%'
                : '+${_utils.formatNumber(_dataStore.state.priceChangePercente!)}%',
          ),
        );
      },
    );
  }
}
