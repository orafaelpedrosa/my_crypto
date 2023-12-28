import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/about_cryptocurrency_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/chart_sparkline_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/link_cryptocurrency_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/tab_price_change_percent_widget.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/core/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/core/shared/widgets/image_coin_widget.dart';
import 'package:mycrypto/app/core/shared/widgets/loading/loading_widget.dart';
import 'package:mycrypto/app/core/shared/widgets/snackbar/snackbar.dart';
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
  UserStore _userStore = Modular.get();

  @override
  void initState() {
    favoritesStore.startFavorites();
    store.getCryptocurrencyById(widget.cryptocurrency.id!);
    store.priceChangePercente(0);
    store.chartStore.paramsChart.id = widget.cryptocurrency.id;
    store.chartStore.paramsChart.days = '1d';
    store.chartStore.paramsChart.vsCurrency =
        _userStore.state.userPreference.vsCurrency;
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
          TripleBuilder<FavoritesStore, List<CryptocurrencySimpleModel>>(
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
                              '${widget.cryptocurrency.name} ${favoritesStore.state.any((element) => element.id == widget.cryptocurrency.id) ? 'foi adicionado ao' : 'foi removido do'} favoritos',
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
      body: TripleBuilder<CryptocurrencyDataStore, CryptocurrencyDetailsModel>(
        store: store,
        builder: (_, triple) {
          if (store.isLoading) {
            return LoadingWidget();
          } else {
            return StreamBuilder<CryptocurrencyDetailsModel>(
              stream: Stream.periodic(
                const Duration(seconds: 30),
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
                      children: <Widget>[
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            ImageCoinWidget(
                              url: snapshot.data!.image!.small ?? '',
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              snapshot.data!.name ?? 'Cripotocurrency',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Text(
                              store.getPriceInCurrency(
                                  _userStore.state.userPreference.vsCurrency!),
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
                          visible: store.chartStore.state.pricesChart != null &&
                              store.chartStore.state.pricesChart!.isNotEmpty,
                          child: ChartSparklineWidget(),
                        ),
                        SizedBox(height: 40),
                        Visibility(
                          visible:
                              store.chartStore.state.pricesChart?.isNotEmpty ??
                                  false,
                          child: Center(
                            child: ToggleSwitch(
                              minHeight: 35.0,
                              initialLabelIndex: selectIndex,
                              inactiveBgColor:
                                  Theme.of(context).colorScheme.onBackground,
                              inactiveFgColor:
                                  Theme.of(context).colorScheme.secondary,
                              activeFgColor:
                                  Theme.of(context).colorScheme.secondary,
                              dividerColor: Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(0.5),
                              totalSwitches: 4,
                              animate: true,
                              borderWidth: 0.5,
                              labels: ['1d', '7d', '30d', '1A'],
                              onToggle: (index) async {
                                selectIndex = index!;
                                await store.chartStore.changeChart(index);
                                await store.priceChangePercente(selectIndex);
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
                          store.state.marketData?.marketCap!.usd.toString() ??
                              '',
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
                          child: AboutCryptocurrencyWidget(
                            about: snapshot.data!.description!.pt!,
                          ),
                        ),
                        Visibility(
                          visible: snapshot.data!.description!.pt! != "",
                          child: SizedBox(height: 40),
                        ),
                        SizedBox(height: 20),
                        LinkCryptocurrencyWidget(
                          title: 'Site Oficial',
                          url: snapshot.data!.links!.homepage!.first,
                        ),
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
