import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';

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
    return Slidable(
      child: ListTile(
        onTap: onTap,
        leading: ClipOval(
          child: SizedBox.fromSize(
            size: Size(40, 40),
            child: Image.network(
              coin.image!,
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
        title: Text(
          coin.name!,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  coin.marketCapRank.toString(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Text(
              coin.symbol!.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black87,
                  ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Utils.formatNumber(coin.currentPrice!.toDouble()),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    coin.priceChangePercentage24h.toString().contains('-')
                        ? Icon(
                            Icons.arrow_downward_outlined,
                            color: Colors.red,
                            size: 15,
                          )
                        : Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.green,
                            size: 15,
                          ),
                    SizedBox(width: 5),
                    Text(
                      coin.priceChangePercentage24h.toString().contains('-')
                          ? '${coin.priceChangePercentage24h!.toStringAsFixed(2)}%'
                          : '+' +
                              '${coin.priceChangePercentage24h!.toStringAsFixed(2)}%',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: coin.priceChangePercentage24h
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
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            spacing: 10,
            onPressed: (context) {
              slidableOnTap!(context);
            },
            backgroundColor:
                coin.isFavorite! ? Colors.red : Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            icon: coin.isFavorite! ? Icons.delete : Icons.star_rate_sharp,
            label: coin.isFavorite! ? 'Remover' : 'Favoritar',
          ),
        ],
      ),
    );
  }
}
