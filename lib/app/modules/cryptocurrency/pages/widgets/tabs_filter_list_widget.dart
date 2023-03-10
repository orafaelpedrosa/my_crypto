import 'package:dio/dio.dart';
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
                      color: Color(0xff201F26),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (store.order == 'market_cap_desc') {
                      store.order = 'market_cap_asc';
                    } else if (store.order == 'market_cap_asc') {
                      store.order = 'market_cap_desc';
                    } else {
                      store.order = 'market_cap_desc';
                    }
                    store.orderList(store.order);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xff201F26),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cap. Mercado'),
                          Icon(
                            store.marketsParams.order != 'market_cap_desc'
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color:
                                store.marketsParams.order != 'market_cap_desc'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Modular.to.pushNamed('/settings');
                  },
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
