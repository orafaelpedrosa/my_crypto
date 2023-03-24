import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/wallet/widgets/modal_menu_wallet_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletPage extends StatefulWidget {
  final String title;
  const WalletPage({Key? key, this.title = 'Carteira'}) : super(key: key);
  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  final WalletStore store = Modular.get();

  @override
  void initState() {
    store.getWallet();
    store.updatePrice();
    store.totalValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return ModalMenuWalletWidget();
                },
              );
            },
          ),
        ],
      ),
      body: TripleBuilder<WalletStore, Exception, List<MyCryptoModel>>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await store.getWallet();
              await store.updatePrice();
            },
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  DoughnutSeries<MyCryptoModel, String>(
                    dataSource: store.state,
                    xValueMapper: (MyCryptoModel data, _) => data.id,
                    yValueMapper: (MyCryptoModel data, _) => data.totalValue,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: false,
                      labelPosition: ChartDataLabelPosition.outside,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
