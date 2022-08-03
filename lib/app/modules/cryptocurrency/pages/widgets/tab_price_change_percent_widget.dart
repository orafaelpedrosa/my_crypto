import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';

class TabPriceChangePercentageWidget extends StatefulWidget {
  double priceChange = 0;
  TabPriceChangePercentageWidget({
    Key? key,
    required this.priceChange,
  }) : super(key: key);

  @override
  State<TabPriceChangePercentageWidget> createState() =>
      _TabPriceChangePercentageWidgetState();
}

class _TabPriceChangePercentageWidgetState
    extends State<TabPriceChangePercentageWidget> {
  final CryptocurrencyDataStore _store = Modular.get<CryptocurrencyDataStore>();
  Utils _utils = Utils();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder<CryptocurrencyDataStore, DioError,
        CryptocurrencyDetailsModel>(
      store: _store,
      builder: (_, triplo) {
        if (_store.chartStore.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.priceChange > 0 ? Colors.green : Colors.red,
            ),
            child: Text(
              widget.priceChange.isNegative
                  ? '${_utils.formatNumber(widget.priceChange)}%'
                  : '+${_utils.formatNumber(widget.priceChange)}%',
            ),
          );
        }
      },
    );
  }
}
