import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/cryptocurrency_item_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/shimmer_cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';

class CryptocurrencyListWidget extends StatefulWidget {
  const CryptocurrencyListWidget({Key? key}) : super(key: key);

  @override
  State<CryptocurrencyListWidget> createState() =>
      _CryptocurrencyListWidgetState();
}

class _CryptocurrencyListWidgetState extends State<CryptocurrencyListWidget> {
  ListCryptocurrenciesStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        if (store.isLoading) {
          return Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                shadowColor: Colors.transparent,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    10,
                    (index) => const ShimmerCryptocurrencyListWidget(),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: StreamBuilder<List<CryptocurrencySimpleModel>>(
              stream: Stream.periodic(
                const Duration(seconds: 5),
                (_) {
                  if (!store.search) {
                    // store.getListCryptoStream();
                  }
                  return store.state;
                },
              ),
              initialData: const [],
              builder: (context, snapshot) {
                return RefreshIndicator(
                  onRefresh: () async {
                    store.getListCryptocurrencies();
                  },
                  child: ListView.separated(
                    itemCount: store.state.length,
                    itemBuilder: (_, index) {
                      store.getFormatImage(store.state[index].image);
                      return CryptocurrencyItemListWidget(
                        coin: store.state[index],
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black12,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
