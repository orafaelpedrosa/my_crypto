import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/chart_sparkline_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/tab_price_change_percent_widget.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';
import 'package:mycrypto/app/core/utils/utils.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';
import 'package:mycrypto/app/shared/widgets/read_more_text.dart';
import 'package:mycrypto/app/shared/widgets/snackbar/snackbar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CryptocurrencyDetailsPage extends StatefulWidget {
  final CryptocurrencySimpleModel cryptocurrency;
  final bool fromFavorite;
  const CryptocurrencyDetailsPage({
    Key? key,
    required this.cryptocurrency,
    this.fromFavorite = false,
  }) : super(key: key);

  @override
  State<CryptocurrencyDetailsPage> createState() =>
      _CryptocurrencyDetailsPageState();
}

class _CryptocurrencyDetailsPageState extends State<CryptocurrencyDetailsPage> {
  CryptocurrencyDataStore store = Modular.get();
  FavoritesStore favoritesStore = Modular.get();

  @override
  void initState() {
    favoritesStore.startFavorites();
    store.getCryptocurrencyById(widget.cryptocurrency.id!);
    store.priceChangePercente(0);
    store.chartStore.paramsChart.id = widget.cryptocurrency.id;
    store.chartStore.paramsChart.days = '1d';
    store.chartStore.paramsChart.vsCurrency = 'usd';
    store.chartStore.getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int selectIndex = 0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBarWidget(
        onBackPressed: () {
          widget.fromFavorite
              ? Modular.to.pushReplacementNamed('/home/favorites/')
              : Modular.to.pushReplacementNamed('/home/cryptocurrency/');
        },
        title: widget.cryptocurrency.symbol!.toUpperCase(),
        elevation: 1,
        showAction: true,
        actions: [
          TripleBuilder<FavoritesStore, Exception,
              List<CryptocurrencySimpleModel>>(
            store: favoritesStore,
            builder: (_, triple) {
              return triple.isLoading
                  ? Container(
                      padding: EdgeInsets.all(5),
                      height: 55,
                      width: 55,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: favoritesStore.isFavorite(widget.cryptocurrency)
                          ? Icon(
                              Icons.star_rate_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : Icon(
                              Icons.star_outline_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      onPressed: () {
                        favoritesStore
                            .toggleFavorite(widget.cryptocurrency)
                            .then(
                          (value) async {
                            await openInfoSnackBar(
                              context,
                              '${widget.cryptocurrency.name} ${favoritesStore.state.any((element) => element.id == widget.cryptocurrency.id) ? 'foi adicionado' : 'foi removido'} dos favoritos',
                              favoritesStore.isFavorite(widget.cryptocurrency),
                            );
                          },
                        );
                      },
                    );
            },
          ),
        ],
      ).build(context) as AppBar,
      body: TripleBuilder<CryptocurrencyDataStore, DioError,
          CryptocurrencyDetailsModel>(
        store: store,
        builder: (_, triple) {
          if (store.isLoading) {
            return LoadingWidget();
          } else {
            return StreamBuilder<CryptocurrencyDetailsModel>(
              stream: Stream.periodic(
                const Duration(seconds: 10),
                (_) {
                  store.getStreamCryptocurrency(
                      widget.cryptocurrency.id!, selectIndex);
                  return store.state;
                },
              ),
              initialData: store.state,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          snapshot.data!.name ?? 'Cripotocurrency',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              Utils.formatNumber(snapshot
                                  .data!.marketData!.currentPrice!.usd!),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Spacer(),
                            TabPriceChangePercentageWidget(),
                          ],
                        ),
                        SizedBox(height: 45),
                        Visibility(
                          visible:
                              store.chartStore.state.pricesChart!.isNotEmpty,
                          child: ChartSparklineWidget(),
                        ),
                        SizedBox(height: 40),
                        Visibility(
                          visible:
                              store.chartStore.state.pricesChart!.isNotEmpty,
                          child: Center(
                            child: ToggleSwitch(
                              minHeight: 35.0,
                              initialLabelIndex: selectIndex,
                              inactiveBgColor:
                                  Theme.of(context).cardColor.withOpacity(0.05),
                              inactiveFgColor:
                                  Theme.of(context).colorScheme.secondary,
                              activeFgColor:
                                  Theme.of(context).colorScheme.secondary,
                              dividerColor:
                                  Theme.of(context).colorScheme.onBackground,
                              totalSwitches: 4,
                              animate: true,
                              borderWidth: 0.5,
                              labels: ['1d', '7d', '30d', '1a'],
                              onToggle: (index) {
                                selectIndex = index!;
                                store.chartStore.changeChart(index);
                                store.priceChangePercente(selectIndex);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Capitalização de Mercado',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '\$ ${Utils.formatNumber(snapshot.data!.marketData!.marketCap!.usd!)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        SizedBox(height: 25),
                        Visibility(
                          visible: snapshot.data!.description!.pt! != "",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sobre',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 10),
                              ReadMoreText(
                                snapshot.data!.description!.pt!,
                                trimLines: 5,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                colorClickableText:
                                    Theme.of(context).colorScheme.primary,
                                trimMode: TrimMode.Line,
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
