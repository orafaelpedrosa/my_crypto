import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_details_model/cryptocurrency_details_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_data_store.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';

class CryptocurrencyDetailsPage extends StatefulWidget {
  final String id;
  final String name;
  const CryptocurrencyDetailsPage({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<CryptocurrencyDetailsPage> createState() =>
      _CryptocurrencyDetailsPageState();
}

class _CryptocurrencyDetailsPageState extends State<CryptocurrencyDetailsPage> {
  CryptocurrencyDataStore store = Modular.get();

  @override
  void initState() {
    store.getCryptocurrencyById(widget.id);
    super.initState();
  }

  void getCrypto() {
    store.getCryptocurrencyById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.name,
        elevation: 1,
      ).build(context) as AppBar,
      body: Center(
        child: TripleBuilder<CryptocurrencyDataStore, DioError,
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
                    store.getStreamCryptocurrency(widget.id);
                    return store.state;
                  },
                ),
                initialData: store.state,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
