import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/search_bar_coin_widget.dart';
import 'package:mycrypto/app/modules/wallet/stores/search_store.dart';
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
  final SearchStore _searchStore = Modular.get();

  @override
  void initState() {
    store.getWallet();
    _searchStore.getTest('');
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: TripleBuilder<WalletStore, List<MyCryptoModel>>(
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 400,
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
                            xValueMapper: (MyCryptoModel data, _) => data.id,
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
