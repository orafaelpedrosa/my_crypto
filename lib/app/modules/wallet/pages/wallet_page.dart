import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/markets_params_model.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/empty_wallet_widget.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/search_bar_coin_widget.dart';
import 'package:mycrypto/app/modules/wallet/stores/search_store.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/shared/widgets/image_coin_widget.dart';
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
  final UserStore _userStore = Modular.get();
  final MarketsParamsModel params = MarketsParamsModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store.getAllWalletCoins();
      if (_searchStore.state.isEmpty) {
        _searchStore.getSearchCoin('');
      }
      store.updatePrice();
      store.totalValue();
      params.vsCurrency = _userStore.state.userPreference.vsCurrency;
      store.getListCryptocurrenciesData(params);
    });

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
      body: TripleBuilder<WalletStore, List<MyCryptoModel>>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return store.state.isNotEmpty
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
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
                              xValueMapper: (MyCryptoModel data, _) =>
                                  data.name,
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
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: store.coinsList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            minVerticalPadding: 0,
                            onTap: () async {},
                            leading: ImageCoinWidget(
                              size: 20,
                              url: store.coinsList[index].image!,
                            ),
                            title: Text(
                              store.coinsList[index].name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.onBackground,
                              size: 15,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Theme.of(context).colorScheme.primary,
                            height: 0,
                            thickness: 0.25,
                          );
                        },
                      ),
                    ],
                  ),
                )
              : EmptyWalletWidget();
        },
      ),
    );
  }
}
