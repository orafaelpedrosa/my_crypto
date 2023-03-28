import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
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

  MyCryptoModel crypto = MyCryptoModel();

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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 2,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/home/wallet/add');
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: TripleBuilder<WalletStore, List<MyCryptoModel>>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // if (store.state.isEmpty) {
            //   return EmptyWalletWidget();
            // }
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
      ),
    );
  }
}
