import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/shimmer_cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/favorites/pages/widgets/no_favorites_widgets.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';

class FavoritesPage extends StatefulWidget {
  final String title;
  const FavoritesPage({Key? key, this.title = 'Favoritas'}) : super(key: key);
  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  final FavoritesStore store = Modular.get();

  @override
  void initState() {
    store.getCryptocurrenciesByIDs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: TripleBuilder<FavoritesStore, Exception,
              List<CryptocurrencySimpleModel>>(
            store: store,
            builder: (context, triple) {
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
              } else if (triple.error != null) {
                return Center(
                  child: Text(triple.error.toString()),
                );
              } else {
                return (store.listIDs.length == 0)
                    ? NoFavoritesWidget()
                    : Container(
                        color: Theme.of(context).backgroundColor,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                itemCount: triple.state.length,
                                itemBuilder: (context, index) {
                                  // return CryptocurrencyItemListWidget(
                                  //   coin: triple.state[index],
                                  // );
                                  final coin = triple.state[index];
                                  return Container(
                                    color: Theme.of(context).backgroundColor,
                                    child: ListTile(
                                      onTap: () {
                                        Modular.to.pushReplacementNamed(
                                          '/home/cryptocurrency/details',
                                          arguments: coin,
                                        );
                                      },
                                      leading: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: Size(40, 40),
                                          child: Image.network(
                                            coin.image!,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        coin.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                coin.marketCapRank.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                      color: Colors.black87,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            coin.symbol!.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  color: Colors.black87,
                                                ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                Utils.formatNumber(coin
                                                    .currentPrice!
                                                    .toDouble()),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3!
                                                    .copyWith(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  coin.priceChangePercentage24h
                                                          .toString()
                                                          .contains('-')
                                                      ? Icon(
                                                          Icons
                                                              .arrow_downward_outlined,
                                                          color: Colors.red,
                                                          size: 15,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .arrow_upward_outlined,
                                                          color: Colors.green,
                                                          size: 15,
                                                        ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    coin.priceChangePercentage24h
                                                            .toString()
                                                            .contains('-')
                                                        ? '${coin.priceChangePercentage24h!.toStringAsFixed(2)}%'
                                                        : '+' +
                                                            '${coin.priceChangePercentage24h!.toStringAsFixed(2)}%',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                          color: coin
                                                                  .priceChangePercentage24h
                                                                  .toString()
                                                                  .contains('-')
                                                              ? Colors.red
                                                              : Colors.green,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, index) => const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
