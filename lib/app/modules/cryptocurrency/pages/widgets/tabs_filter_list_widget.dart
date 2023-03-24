import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';

class TabsFilterListWidget extends StatefulWidget {
  const TabsFilterListWidget({Key? key}) : super(key: key);

  @override
  State<TabsFilterListWidget> createState() => _TabsFilterListWidgetState();
}

class _TabsFilterListWidgetState extends State<TabsFilterListWidget> {
  final ListCryptocurrenciesStore store = Modular.get();
  final LoginStore loginStore = Modular.get();
  final FavoritesStore favoritesStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TripleBuilder<ListCryptocurrenciesStore, DioError,
              List<CryptocurrencySimpleModel>>(
          store: store,
          builder: (_, triple) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    store.marketsParams.vsCurrency =
                        store.marketsParams.vsCurrency == 'usd' ? 'brl' : 'usd';
                    store.getListCryptocurrencies();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            store.marketsParams.vsCurrency == 'usd'
                                ? 'USD'
                                : 'BRL',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  height: 1,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    store.setMarketParamsOrder('market_cap_desc');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cap. Mercado',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  height: 1,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 14,
                                ),
                          ),
                          Icon(
                            store.marketsParams.order != 'market_cap_desc'
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color:
                                store.marketsParams.order != 'market_cap_desc'
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    store.setMarketParamsOrder('volume_desc');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Volume 24h',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  height: 1,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 14,
                                ),
                          ),
                          Icon(
                            store.marketsParams.order != 'volume_desc'
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: store.marketsParams.order != 'volume_desc'
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.percent_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: Text(
                            'Movimentação de Preço',
                          ),
                          actions: [
                            _cupertinoActionSheetAction('1 hora', '1h'),
                            _cupertinoActionSheetAction('24 horas', '24h'),
                            _cupertinoActionSheetAction('7 dias', '7d'),
                            _cupertinoActionSheetAction('30 dias', '30d'),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              Modular.to.pop();
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }),
    );
  }

  _cupertinoActionSheetAction(String text, String value) {
    return CupertinoActionSheetAction(
      child: Text(
        text,
        style: TextStyle(
          color: store.marketsParams.priceChangePercentage == value
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w300,
        ),
      ),
      onPressed: () async {
        store.marketsParams.priceChangePercentage = value;
        store.cryptocurrencies.clear();
        store.getListCryptocurrencies();
        Modular.to.pop();
      },
    );
  }
}
