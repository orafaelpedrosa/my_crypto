import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/shimmer_cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/slidable_item_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';
import 'package:mycrypto/app/core/shared/widgets/snackbar/snackbar.dart';

class CryptocurrencyListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const CryptocurrencyListWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<CryptocurrencyListWidget> createState() =>
      _CryptocurrencyListWidgetState();
}

class _CryptocurrencyListWidgetState extends State<CryptocurrencyListWidget> {
  ListCryptocurrenciesStore store = Modular.get();
  FavoritesStore favoritesStore = Modular.get();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
              widget.scrollController.position.maxScrollExtent &&
          !store.isLoading) {
        store.marketsParams.page = store.marketsParams.page! + 1;
        store.getListCryptocurrencies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ListCryptocurrenciesStore,
        List<CryptocurrencySimpleModel>>(
      store: store,
      builder: (_, triple) {
        // if (triple.event == TripleEvent.error) {
        //   DioError dioError = triple.error as DioError;
        //   return Expanded(
        //     child: ErrorHttpWidget(
        //       error: dioError.response!.statusCode.toString(),
        //       subtitle:
        //           'Infelizmente não foi possível carregar a lista de criptomoedas devido a um erro no servidor.',
        //       onTap: () {
        //         store.getListCryptocurrencies();
        //       },
        //     ),
        //   );
        // } else
        if (store.isLoading && store.state.isEmpty) {
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
                const Duration(seconds: 60),
                (_) {
                  store.getListCryptoStream();
                  return store.state;
                },
              ),
              initialData: const [],
              builder: (context, snapshot) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await store.getListCryptocurrencies();
                  },
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: widget.scrollController,
                    child: ListView.separated(
                      controller: widget.scrollController,
                      itemCount: store.state.length,
                      itemBuilder: (_, index) {
                        store.state[index].isFavorite = favoritesStore.state
                            .any((element) =>
                                element.id == store.state[index].id);
                        store.state[index].priceChangePercentageTime =
                            store.getPriceChangePercentage(store.state[index]);

                        return Column(
                          children: <Widget>[
                            Visibility(
                              visible: store.isLoading && index == 0,
                              child: LinearProgressIndicator(
                                minHeight: 1,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SlidableItemListWidget(
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
                              slidableOnTap: (context) async {
                                favoritesStore
                                    .toggleFavorite(store.state[index])
                                    .then(
                                  (value) async {
                                    await openInfoSnackBar(
                                      context,
                                      '${store.state[index].name} ${favoritesStore.state.any((element) => element.id == store.state[index].id) ? 'foi adicionado' : 'foi removido'} aos favoritos',
                                      favoritesStore.isFavorite(
                                        store.state[index],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, index) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.transparent,
                      ),
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
