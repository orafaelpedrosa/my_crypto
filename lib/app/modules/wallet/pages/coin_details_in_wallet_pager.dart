import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CoinDetaisInWalletPage extends StatefulWidget {
  final MyCryptoModel coin;
  CoinDetaisInWalletPage({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  State<CoinDetaisInWalletPage> createState() => _CoinDetaisInWalletPageState();
}

class _CoinDetaisInWalletPageState extends State<CoinDetaisInWalletPage> {
  final WalletStore store = Modular.get();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      store.getMarketChart(widget.coin.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double a = widget.coin.averagePrice!.toDouble() * widget.coin.amount!;
    double b = widget.coin.currentPrice!.toDouble() * widget.coin.amount!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBarWidget(
        title: widget.coin.name,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed(
                '/wallet/transaction',
                arguments: widget.coin.id,
              );
            },
            icon: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Modular.to.pushNamed(
                              '/wallet/transaction',
                              arguments: widget.coin.id,
                            );
                          },
                          leading: Icon(
                            Icons.history,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          title: Text(
                            'Histórico',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Modular.to.pushNamed(
                              '/wallet/edit',
                              arguments: widget.coin,
                            );
                          },
                          leading: Icon(
                            Icons.mode_edit_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          title: Text(
                            'Editar',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Modular.to.pushNamed(
                              '/wallet/delete',
                              arguments: widget.coin,
                            );
                          },
                          leading: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          title: Text(
                            'Excluir',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.mode_edit_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ).build(context) as AppBar,
      body: TripleBuilder(
        store: store,
        builder: (context, triple) {
          if (triple.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SfSparkLineChart(
                    data: store.cryptoData.price![0],
                    color: Theme.of(context).colorScheme.secondary,
                    trackball: SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap,
                      color: Theme.of(context).colorScheme.secondary,
                      labelStyle:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantidade',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      '${widget.coin.amount!.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Valor investido',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      'R\$ ${a.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Valor atual',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      'R\$ ${b.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lucro',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      'R\$ ${widget.coin.profit}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Variação',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      '${widget.coin.profitPercentage}%',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
