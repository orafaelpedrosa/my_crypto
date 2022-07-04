import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/core/repositories/cryptocurrency_repository.dart';
import 'package:mycrypto/app/modules/crypto/pages/widget/crypto_card_widget.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_store.dart';
import 'package:mycrypto/app/shared/widgets/error/error_type_widget.dart';
import 'package:mycrypto/app/shared/widgets/loading/loading_widget.dart';
import 'package:mycrypto/app/shared/widgets/search_input/search_input_widget.dart';

class CryptocurrencyListWidget extends StatefulWidget {
  const CryptocurrencyListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CryptocurrencyListWidgetState createState() =>
      _CryptocurrencyListWidgetState();
}

class _CryptocurrencyListWidgetState extends State<CryptocurrencyListWidget> {
  CryptoListStore store = Modular.get();
  CryptocurrencyRepository repository = Modular.get();
  CryptoStore cryptoStore = Modular.get();
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    _searchController.clear();
    store.getListCrypto();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<CryptoListStore, DioError, List<CryptocurrencyModel>>(
      store: store,
      builder: (_, triple) {
        if (store.isLoading) {
          return Center(
            child: LoadingWidget(
              color: Theme.of(context).primaryColor,
            ),
          );
        } else if (triple.event == TripleEvent.error) {
          log('Error: ${triple.error!.response!.statusCode}');
          return ErrorHttpWidget(
            error: triple.error!.response!.statusCode.toString(),
          );
        } else {
          return Column(
            children: [
              SizedBox(height: 5),
              SearchInputWidget(
                controller: _searchController,
                focusNode: _searchFocus,
                hintText: 'Pesquise uma criptomoeda',
                enableSuggestions: false,
                onChange: (value) {
                  if (value != '') {
                    store.searchCrypto(value!);
                    store.search = true;
                  } else {
                    store.search = false;
                    store.updateState(store.listCrypto);
                  }
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<CryptocurrencyModel>>(
                  stream: Stream.periodic(
                    const Duration(seconds: 4),
                    (_) {
                      if (!store.search) {
                        store.getListCrypto();
                      }
                      setState(() {
                        cryptoStore.getCryptoData();
                      });
                      return store.state;
                    },
                  ),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        snapshot.data!.isEmpty) {
                      return Center(
                        child: LoadingWidget(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          store.getListCrypto();
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        color: Colors.white,
                        child: ListView.separated(
                          itemCount: store.state.length,
                          itemBuilder: (_, index) {
                            final cryptocurrency = store.state[index];
                            cryptocurrency.logoFormat =
                                getFormatImage(cryptocurrency.logoUrl);
                            return CryptoCardWidget(
                              cryptoModel: cryptocurrency,
                            );
                          },
                          separatorBuilder: (_, __) => Divider(
                            height: 0.5,
                            color: Colors.black12,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  String getFormatImage(String? url) {
    if (url == null) {
      return 'null';
    } else {
      int ponto = url.lastIndexOf('.');
      String imageFormat = url.substring(ponto + 1, url.length);
      return imageFormat;
    }
  }
}
