import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/chart_sparkline7d_widget.dart';
import 'package:mycrypto/app/shared/utils/utils.dart';
import 'package:mycrypto/app/shared/widgets/read_more_text.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CryptocurrencyDetailsPage extends StatefulWidget {
  final CryptocurrencySimpleModel cryptocurrency;
  const CryptocurrencyDetailsPage({
    Key? key,
    required this.cryptocurrency,
  }) : super(key: key);

  @override
  State<CryptocurrencyDetailsPage> createState() =>
      _CryptocurrencyDetailsPageState();
}

class _CryptocurrencyDetailsPageState extends State<CryptocurrencyDetailsPage> {
  CryptocurrencyDataStore store = Modular.get();

  Utils utils = Utils();

  @override
  void initState() {
    store.getCryptocurrencyById(widget.cryptocurrency.id!);
    store.chartStore.chartsParamsModel.id = widget.cryptocurrency.id;
    store.chartStore.chartsParamsModel.days = '1d';
    store.chartStore.chartsParamsModel.vsCurrency = 'usd';
    store.chartStore.getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int selectIndex = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: widget.cryptocurrency.symbol!.toUpperCase(),
        elevation: 1,
        showAction: true,
        iconAction: Icon(
          Icons.star_rate_rounded,
          color: Theme.of(context).primaryColor,
        ),
      ).build(context) as AppBar,
      body: TripleBuilder<CryptocurrencyDataStore, DioError,
          CryptocurrencyDetailsModel>(
        store: store,
        builder: (_, triple) {
          if (store.isLoading) {
            return LoadingWidget();
          } else {
            return StreamBuilder<CryptocurrencyDetailsModel>(
              stream: Stream.periodic(
                const Duration(seconds: 10),
                (_) {
                  store.getStreamCryptocurrency(widget.cryptocurrency.id!);
                  return store.state;
                },
              ),
              initialData: store.state,
              builder: (context, snapshot) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          snapshot.data!.name!,
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.black87,
                                  ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          utils.formatNumber(
                              snapshot.data!.marketData!.currentPrice!.usd!),
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 45),
                        ChartSparkline7dWidget(
                          // data: snapshot.data!.marketData!.sparkline7d!.price!,
                          priceChangePercentage7d: snapshot
                              .data!.marketData!.priceChangePercentage7d!
                              .toDouble(),
                        ),
                        SizedBox(height: 40),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: ToggleSwitch(
                            minWidth: 90.0,
                            minHeight: 25.0,
                            initialLabelIndex: selectIndex,
                            inactiveBgColor:
                                Theme.of(context).cardColor.withOpacity(0.05),
                            inactiveFgColor: Theme.of(context).cardColor,
                            activeFgColor: Colors.white,
                            dividerColor:
                                Theme.of(context).cardColor.withOpacity(0.5),
                            totalSwitches: 3,
                            animate: true,
                            borderWidth: 0.5,
                            labels: ['1d', '7d', '30d'],
                            onToggle: (index) {
                              store.chartStore.chartsParamsModel.id =
                                  snapshot.data!.id;
                              store.chartStore.chartsParamsModel.vsCurrency =
                                  'usd';
                              switch (index) {
                                case 0:
                                  store.chartStore.chartsParamsModel.days =
                                      '1d';
                                  break;
                                case 1:
                                  store.chartStore.chartsParamsModel.days =
                                      '7d';
                                  break;
                                case 2:
                                  store.chartStore.chartsParamsModel.days =
                                      '30d';
                              }
                              selectIndex = index!;
                              store.chartStore.getChartData();
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Market Cap:',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          '\$ ${utils.formatNumber(snapshot.data!.marketData!.marketCap!.usd!)}',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black87,
                                  ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Sobre',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 5),
                        ReadMoreText(
                          snapshot.data!.description!.en!,
                          trimLines: 5,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black87),
                          colorClickableText: Theme.of(context).primaryColor,
                          trimMode: TrimMode.Line,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}



                        // Text(
                        //   'Price Max: ${snapshot.data!.marketData!.sparkline7d!.price!.reduce((curr, next) => curr > next ? curr : next)}',
                        //   style:
                        //       Theme.of(context).textTheme.headline4!.copyWith(
                        //             color: Colors.black87,
                        //           ),
                        // ),
                        // Text(
                        //   'Price Min: ${snapshot.data!.marketData!.sparkline7d!.price!.reduce((curr, next) => curr < next ? curr : next)}',
                        //   style:
                        //       Theme.of(context).textTheme.headline4!.copyWith(
                        //             color: Colors.black87,
                        //           ),
                        // ),
                        // Text(
                        //   'Price Atual: ${snapshot.data!.marketData!.currentPrice!.usd}',
                        //   style:
                        //       Theme.of(context).textTheme.headline4!.copyWith(
                        //             color: Colors.black87,
                        //           ),
                        // ),
