import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/shimmer_cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/slidable_item_list_widget.dart';
import 'package:mycrypto/app/modules/favorites/pages/widgets/no_favorites_widgets.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';
import 'package:mycrypto/app/shared/widgets/error/error_type_widget.dart';

class FavoritesPage extends StatefulWidget {
  final String title;
  const FavoritesPage({Key? key, this.title = 'Favoritos'}) : super(key: key);
  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  final FavoritesStore store = Modular.get();
  final UserStore _userStore = Modular.get();

  @override
  void initState() {
    store.marketsParams.vsCurrency = _userStore.state.userPreference.vsCurrency;
    store.marketsParams.order = 'market_cap_desc';
    store.marketsParams.perPage = 100;
    store.marketsParams.page = 1;
    store.marketsParams.sparkline = 'true';
    store.marketsParams.priceChangePercentage = '1h,24h,7d,14d,30d,200d,1y';
    store.getCryptocurrenciesByIDs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                )),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: TripleBuilder<FavoritesStore, List<CryptocurrencySimpleModel>>(
            store: store,
            builder: (context, triple) {
              if (triple.event == TripleEvent.error) {
                DioException dioError = triple.error as DioException;
                return ErrorHttpWidget(
                  error: dioError.response!.statusCode.toString(),
                  subtitle:
                      'Infelizmente não foi possível carregar a sua lista de favoritos.',
                  onTap: () {
                    store.getCryptocurrenciesByIDs();
                  },
                );
              }
              if (triple.isLoading) {
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        10,
                        (index) => const ShimmerCryptocurrencyListWidget(),
                      ),
                    ),
                  ),
                );
              } else {
                return (triple.state.isEmpty)
                    ? NoFavoritesWidget()
                    : Column(
                        children: <Widget>[
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await store.getCryptocurrenciesByIDs();
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: triple.state.length,
                                itemBuilder: (context, index) {
                                  final coin = triple.state[index];
                                  coin.isFavorite = store.isFavorite(coin);
                                  coin.priceChangePercentageTime =
                                      store.getPriceChangePercentage(coin);
                                  return SlidableItemListWidget(
                                    coin: coin,
                                    onTap: () {
                                      Modular.to.pushNamed(
                                        '/home/cryptocurrency/details',
                                        arguments: {
                                          'cryptocurrency': coin,
                                          'fromFavorite': true,
                                        },
                                      );
                                    },
                                    slidableOnTap: (context) async {
                                      store.removeFavoriteByID(coin);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
