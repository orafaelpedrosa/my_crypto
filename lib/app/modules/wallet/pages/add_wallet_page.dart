import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/stores/search_store.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:mycrypto/app/shared/widgets/button/button_primary_widget.dart';
import 'package:mycrypto/app/shared/widgets/image_coin_widget.dart';

class AddWalletPage extends StatefulWidget {
  final CoinSearchModel coin;
  const AddWalletPage({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  State<AddWalletPage> createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  final WalletStore store = Modular.get();
  final SearchStore searchStore = Modular.get();
  final UserStore _userStore = Modular.get();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController priceAverageController = TextEditingController();
  final MyCryptoModel crypto = MyCryptoModel();

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => store.getSimplePriceID(widget.coin.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ImageCoinWidget(
              url: widget.coin.large!,
              size: 30,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                widget.coin.name!,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.swap_vert,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              if (store.fiat == widget.coin.symbol) {
                store.fiat = _userStore.state.userPreference.vsCurrency!;
              } else {
                store.fiat = widget.coin.symbol!;
              }
              store.updateState();
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: TripleBuilder<WalletStore, List<MyCryptoModel>>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              color: Theme.of(context).colorScheme.background,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,
                    child: AutoSizeTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      showCursor: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {}
                      },
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.2,
                          ),
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: MediaQuery.of(context).size.width * 0.2,
                              fontWeight: FontWeight.bold,
                            ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Text(
                    store.fiat,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 20),
                  ButtonPrimaryWidget(
                    text: 'Adicionar a carteira',
                    isLoading: false,
                    onPressed: () {
                      if (store.fiat != widget.coin.symbol) {
                      } else {
                        double amount = double.parse(amountController.text);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
