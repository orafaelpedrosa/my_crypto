import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/cryptocurrency_item_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';

class CryptocurrencyListWidget extends StatefulWidget {
  const CryptocurrencyListWidget({Key? key}) : super(key: key);

  @override
  State<CryptocurrencyListWidget> createState() =>
      _CryptocurrencyListWidgetState();
}

class _CryptocurrencyListWidgetState extends State<CryptocurrencyListWidget> {
  ListCryptocurrenciesStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<CryptocurrencySimpleModel>>(
        stream: Stream.periodic(
          const Duration(seconds: 5),
          (_) {
            if (!store.search) {
              store.getListCryptocurrencies();
            }
            return store.state;
          },
        ),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: LoadingWidget(
                color: Colors.white,
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                store.getListCryptocurrencies();
              },
              child: ListView.builder(
                itemCount: store.state.length,
                itemBuilder: (_, index) {
                  store.getFormatImage(store.state[index].image);
                  return CryptocurrencyItemListWidget(
                    coin: store.state[index],
                  );
                },

              ),
            );
          }
        },
      ),
    );
  }
}
