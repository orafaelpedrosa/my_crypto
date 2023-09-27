import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/operation_historic_enum.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/empty_wallet_widget.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/search_bar_coin_widget.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletPage extends StatefulWidget {
  final String title;
  const WalletPage({Key? key, this.title = 'Carteira'}) : super(key: key);
  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  final WalletStore store = Modular.get();
  final UserStore _userStore = Modular.get();
  final MarketsParamsModel params = MarketsParamsModel();

  @override
  void initState() {
    store.listenWallet(_userStore.user!.uid);
    store.getSearchCoin('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              Modular.to.pushNamed('/wallet/transaction');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarCoinWidget(),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          store.getAllWalletCoins();
        },
        child: TripleBuilder<WalletStore, List<MyCryptoModel>>(
          store: store,
          builder: (_, triple) {
            if (store.state.isEmpty) {
              return EmptyWalletWidget();
            }
            if (store.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (triple.event == TripleEvent.error) {
              return Center(
                child: Text(
                  'Erro ao carregar dados',
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    child: SfCircularChart(
                      margin: EdgeInsets.all(0),
                      legend: Legend(
                        position: LegendPosition.bottom,
                        isVisible: true,
                        isResponsive: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      series: <CircularSeries>[
                        DoughnutSeries<MyCryptoModel, String>(
                          dataSource: store.state,
                          startAngle: 0,
                          xValueMapper: (MyCryptoModel data, _) => data.name,
                          yValueMapper: (MyCryptoModel data, _) =>
                              data.totalValue,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: false,
                            labelPosition: ChartDataLabelPosition.outside,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: triple.state.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: Column(
                                          children: [
                                            Text('Deletar'),
                                          ],
                                        ),
                                        content: Text(
                                          'Tem certeza que deseja deletar ${triple.state[index].name} ? Essa ação não poderá ser desfeita.',
                                        ),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: Text('Não'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: Text('Sim'),
                                            onPressed: () {
                                              store.removeCryptocurrency(
                                                triple.state[index],
                                              );
                                              store.updateTransactionHistory(
                                                triple.state[index],
                                                OperationHistoricEnum.remove,
                                              );
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.remove,
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              Modular.to.pushNamed(
                                '/wallet/coin_details',
                                arguments: triple.state[index],
                              );
                            },
                            title: Text(
                              triple.state[index].name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                            subtitle: Text(
                              triple.state[index].symbol!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Text(
                                //   'R\$ ${triple.state[index].totalValue!.toStringAsFixed(2)}',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .headlineSmall!
                                //       .copyWith(
                                //         color: Theme.of(context)
                                //             .colorScheme
                                //             .secondary,
                                //       ),
                                // ),
                                Text(
                                  '${triple.state[index].averagePrice!.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Theme.of(context).colorScheme.secondary,
                          height: 1,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
