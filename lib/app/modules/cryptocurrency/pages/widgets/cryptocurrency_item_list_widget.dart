import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';

class CryptocurrencyItemListWidget extends StatefulWidget {
  final CryptocurrencySimpleModel coin;
  CryptocurrencyItemListWidget({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  State<CryptocurrencyItemListWidget> createState() =>
      _CryptocurrencyItemListWidgetState();
}

class _CryptocurrencyItemListWidgetState
    extends State<CryptocurrencyItemListWidget> {
  ListCryptocurrenciesStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          '/cryptocurrency/details',
          arguments: widget.coin,
        );
      },
      child: ListTile(
        leading: ClipOval(
          child: SizedBox.fromSize(
            size: Size(40, 40),
            child: Image.network(widget.coin.image!, fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ),
        title: Text(
          widget.coin.name!,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  widget.coin.marketCapRank.toString(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Text(
              widget.coin.symbol!.toUpperCase(),
              style: Theme.of(context).textTheme.headline5!.copyWith(
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
                  Utils.formatNumber(widget.coin.currentPrice!.toDouble()),
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.coin.priceChangePercentage24h
                            .toString()
                            .contains('-')
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
                      widget.coin.priceChangePercentage24h
                              .toString()
                              .contains('-')
                          ? '${widget.coin.priceChangePercentage24h!.toStringAsFixed(2)}%'
                          : '+' +
                              '${widget.coin.priceChangePercentage24h!.toStringAsFixed(2)}%',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: widget.coin.priceChangePercentage24h
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
  }
}
