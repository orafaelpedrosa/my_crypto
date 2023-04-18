import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/shared/widgets/image_coin_widget.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SlidableItemListWidget extends StatelessWidget {
  final CryptocurrencySimpleModel coin;
  final Function()? onTap;
  final Function(BuildContext context)? slidableOnTap;
  const SlidableItemListWidget({
    Key? key,
    required this.coin,
    this.onTap,
    this.slidableOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesStore store = Modular.get();
    String price = '0.00';
    if (coin.currentPrice != null) {
      price = formatPrice(coin.currentPrice!.toDouble());
    }
    if (coin.marketCapRank.toString().length > 4) {
      coin.marketCapRank =
          int.parse(coin.marketCapRank.toString().substring(0, 4));
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Slidable(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageCoinWidget(
                  size: 40,
                  url: coin.image ?? '',
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.24,
                      child: Text(
                        coin.name ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              overflow: TextOverflow.clip,
                            ),
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 3),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              coin.marketCapRank.toString() != 'null'
                                  ? '#${coin.marketCapRank!.toString()}'
                                  : '#',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    height: 1,
                                  ),
                              overflow: TextOverflow.visible,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            coin.symbol!.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                            overflow: TextOverflow.visible,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Container(
                  width: 75,
                  child: SfSparkLineChart(
                    width: 1,
                    color: coin.priceChangePercentage7dInCurrency != 0
                        ? !coin.priceChangePercentageTime
                                .toString()
                                .contains('-')
                            ? Colors.green
                            : Colors.red
                        : Colors.blue,
                    axisLineColor: Colors.transparent,
                    data: coin.sparklineIn7d!.price ?? [1, 1, 1, 1, 1, 1, 1],
                    marker: SparkChartMarker(
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          price,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            coin.priceChangePercentageTime != 0
                                ? !coin.priceChangePercentageTime
                                        .toString()
                                        .contains('-')
                                    ? Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Colors.green,
                                        size: 15,
                                      )
                                    : Icon(
                                        Icons.arrow_downward_outlined,
                                        color: Colors.red,
                                        size: 15,
                                      )
                                : Icon(
                                    Icons.attach_money_rounded,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                            SizedBox(width: 5),
                            Text(
                              coin.priceChangePercentageTime != 0
                                  ? !coin.priceChangePercentageTime
                                          .toString()
                                          .contains('-')
                                      ? '+${coin.priceChangePercentageTime!.toStringAsFixed(2)}%'
                                      : '${coin.priceChangePercentageTime!.toStringAsFixed(2)}%'
                                  : '-',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: coin.priceChangePercentageTime != 0
                                        ? !coin.priceChangePercentageTime
                                                .toString()
                                                .contains('-')
                                            ? Colors.green
                                            : Colors.red
                                        : Colors.blue,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: <Widget>[
              TripleBuilder<FavoritesStore, List<CryptocurrencySimpleModel>>(
                  store: store,
                  builder: (_, triple) {
                    return SlidableAction(
                      flex: 1,
                      spacing: 10,
                      autoClose: false,
                      onPressed: slidableOnTap,
                      backgroundColor: store.isFavorite(coin)
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.background,
                      icon: store.isFavorite(coin)
                          ? Icons.delete
                          : Icons.star_rate_sharp,
                      label: store.isFavorite(coin) ? 'Remover' : 'Favoritar',
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  String formatPrice(double price) {
    if (price.toString().length > 1 && price.toString() != 'null') {
      if (price < 1) {
        return price.toStringAsFixed(6);
      } else {
        if (price.toString().length > 8) {
          return '${(price / 1000000).toStringAsFixed(6)}M';
        } else {
          return price.toStringAsFixed(2);
        }
      }
    }
    return '0';
  }
}
