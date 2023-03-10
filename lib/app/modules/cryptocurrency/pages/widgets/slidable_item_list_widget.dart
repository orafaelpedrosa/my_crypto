import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
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
    String price = formatPrice(coin.currentPrice!.toDouble());

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Color(0xff201F26),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Slidable(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size(40, 40),
                    child: Image.network(
                      coin.image ?? '',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
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
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
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
                                  ? '#${coin.marketCapRank.toString()}'
                                  : '#',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
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
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Container(
                  width: 80,
                  child: SfSparkLineChart(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary,
                    axisLineColor: Colors.transparent,
                    data: coin.sparklineIn7d!.price,
                    marker: SparkChartMarker(
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
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
                          children: [
                            coin.priceChangePercentage24h != null
                                ? !coin.priceChangePercentage24h!
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
                              coin.priceChangePercentage24h != null
                                  ? !coin.priceChangePercentage24h!
                                          .toString()
                                          .contains('-')
                                      ? '+${coin.priceChangePercentage24h!.toStringAsFixed(2)}%'
                                      : '${coin.priceChangePercentage24h!.toStringAsFixed(2)}%'
                                  : '-',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: coin.priceChangePercentage24h != null
                                        ? !coin.priceChangePercentage24h!
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
            children: [
              TripleBuilder<FavoritesStore, Exception,
                      List<CryptocurrencySimpleModel>>(
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
