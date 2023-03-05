import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/slidable_item_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/shimmer_cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';

class CryptocurrencyListWidget extends StatefulWidget {
  const CryptocurrencyListWidget({Key? key}) : super(key: key);

  @override
  State<CryptocurrencyListWidget> createState() =>
      _CryptocurrencyListWidgetState();
}

class _CryptocurrencyListWidgetState extends State<CryptocurrencyListWidget> {
  ListCryptocurrenciesStore store = Modular.get();
  FavoritesStore favoritesStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ListCryptocurrenciesStore, DioError,
        List<CryptocurrencySimpleModel>>(
      store: store,
      builder: (_, triple) {
        if (store.isLoading) {
          return Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                shadowColor: Colors.transparent,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    10,
                    (index) => const ShimmerCryptocurrencyListWidget(),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: StreamBuilder<List<CryptocurrencySimpleModel>>(
              stream: Stream.periodic(
                const Duration(seconds: 20),
                (_) {
                  store.getListCryptoStream();

                  return store.state;
                },
              ),
              initialData: const [],
              builder: (context, snapshot) {
                return RefreshIndicator(
                  onRefresh: () async {
                    store.getListCryptocurrencies();
                  },
                  child: ListView.separated(
                    itemCount: store.state.length,
                    itemBuilder: (_, index) {

                      final isFavorite = favoritesStore.state.any(
                          (element) => element.id == store.state[index].id);

                          
                      store.state[index].isFavorite = isFavorite;


                      store.getFormatImage(store.state[index].image);
                      return SlidableItemListWidget(
                        coin: store.state[index],
                        onTap: () {
                          Modular.to.pushNamed(
                            '/home/cryptocurrency/details',
                            arguments: {
                              'cryptocurrency': store.state[index],
                              'fromFavorite': false,
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black12,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
