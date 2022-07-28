import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/chart_sparkline7d_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';

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

  @override
  void initState() {
    store.getCryptocurrencyById(widget.cryptocurrency.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: widget.cryptocurrency.symbol!.toUpperCase(),
        elevation: 1,
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
                          snapshot.data!.marketData!.currentPrice!.usd!
                              .toString(),
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 45),
                        ChartSparkline7dWidget(
                          data: snapshot.data!.marketData!.sparkline7d!.price!,
                          priceChangePercentage7d: snapshot
                              .data!.marketData!.priceChangePercentage7d!
                              .toDouble(),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Sobre',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          snapshot.data!.description!.en!,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black87,
                                  ),
                          textAlign: TextAlign.justify,
                        ),
                        // Html(
                        //   data: snapshot.data!.description!.en!,
                        // ),
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
