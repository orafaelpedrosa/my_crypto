import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/core/utils/formatters_services.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/modal_change_price_widget.dart';
import 'package:mycrypto/app/modules/wallet/pages/widgets/modal_change_time_widget.dart';
import 'package:mycrypto/app/modules/wallet/stores/add_wallet_store.dart';
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
  final AddWalletStore store = Modular.get();
  final WalletStore walletStore = Modular.get();
  final SearchStore searchStore = Modular.get();
  final UserStore _userStore = Modular.get();

  final TextEditingController amountController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final MyCryptoModel crypto = MyCryptoModel();

  @override
  void initState() {
    store.fiat = widget.coin.symbol!;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await walletStore
          .getSimplePriceID(widget.coin.id!)
          .whenComplete(() async {
        FocusScope.of(context).requestFocus(_focusNode);
      });
      if (_userStore.state.userPreference.vsCurrency == 'BRL') {
        await walletStore.getPriceDolarInBRL();
      }
    });
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
                overflow: TextOverflow.visible,
              ),
            ),
            Visibility(
              visible: widget.coin.marketCapRank != null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    '#${widget.coin.marketCapRank?.toString()}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          height: 1,
                        ),
                    overflow: TextOverflow.visible,
                    maxLines: 1,
                  ),
                ),
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
              walletStore.updateState();
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: TripleBuilder<WalletStore, List<MyCryptoModel>>(
          store: walletStore,
          builder: (_, triple) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.background,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeTextField(
                        focusNode: _focusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        showCursor: false,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            crypto.amount = double.parse(value);
                          } else {
                            crypto.amount = 0;
                          }
                          walletStore.updateState();
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
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.2,
                                fontWeight: FontWeight.bold,
                              ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      store.fiat,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    triple.isLoading
                        ? CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                            strokeWidth: 1.5,
                          )
                        : Text(
                            walletStore.cryptoModel.currentPrice == null
                                ? '0,00 por moeda'
                                : '${FormattersServices.priceInCurrencyFormat(walletStore.cryptoModel.currentPrice!.toStringAsFixed(2))} por moeda',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                    const SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.onBackground,
                                context: context,
                                builder: (context) {
                                  return ModalChangeTimeWidget();
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    FormattersServices.formatDateTime(
                                        walletStore.date),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.onBackground,
                                context: context,
                                builder: (context) {
                                  return ModalChangePriceWidget();
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on_outlined,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Preço por moeda',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonPrimaryWidget(
                      text: 'Adicionar a carteira',
                      isLoading: triple.isLoading,
                      onPressed: () async {
                        walletStore.cryptoModel.id = widget.coin.id;
                        walletStore.cryptoModel.name = widget.coin.name;
                        walletStore.cryptoModel.symbol = widget.coin.symbol;
                        walletStore.cryptoModel.averagePrice =
                            walletStore.cryptoModel.currentPrice!.toDouble();
                        if (store.fiat == widget.coin.symbol) {
                          walletStore.cryptoModel.amount =
                              double.parse(amountController.text);
                        } else {
                          walletStore.cryptoModel.amount =
                              double.parse(amountController.text) /
                                  walletStore.cryptoModel.currentPrice!
                                      .toDouble();
                        }
                        await walletStore
                            .addCryptocurrency(walletStore.cryptoModel)
                            .then((value) async {
                          await walletStore.getAllWalletCoins();
                          await walletStore.updatePrice();
                          await walletStore.totalValue();
                        });
                        Modular.to.pushNamedAndRemoveUntil('/home/wallet/',
                            ModalRoute.withName('/home/wallet/'));
                      },
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
