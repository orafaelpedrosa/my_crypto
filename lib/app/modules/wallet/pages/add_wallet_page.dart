import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/models/my_crypto_model.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/shared/widgets/button/button_primary_widget.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';

class AddWalletPage extends StatefulWidget {
  const AddWalletPage({Key? key}) : super(key: key);

  @override
  State<AddWalletPage> createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  final WalletStore store = Modular.get();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController priceAverageController = TextEditingController();
  final MyCryptoModel crypto = MyCryptoModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Adicionar Criptomoeda ',
        onBackPressed: () {
          Modular.to.pushReplacementNamed('/home/wallet/');
        },
      ).build(context) as PreferredSizeWidget?,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: amountController,
              hintText: 'Quantidade',
              keyboardType: TextInputType.number,
              onChange: (value) {
                store.crypto.amount =
                    amountController.text.isEmpty ? 0 : double.parse(value!);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldWidget(
              controller: priceAverageController,
              hintText: 'Preço médio',
              keyboardType: TextInputType.number,
              onChange: (value) {
                store.crypto.averagePrice = priceAverageController.text.isEmpty
                    ? 0
                    : double.parse(value!);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldWidget(
              controller: idController,
              hintText: 'ID',
              keyboardType: TextInputType.name,
              onChange: (value) {
                store.crypto.id = idController.text;
              },
            ),
            SizedBox(
              height: 10,
            ),
            ButtonPrimaryWidget(
              text: 'Adicionar',
              isLoading: store.isLoading,
              onPressed: () async {
                crypto.id = idController.text;
                crypto.amount = double.parse(amountController.text);
                crypto.averagePrice = double.parse(priceAverageController.text);
                await store.addCryptocurrency(crypto).then(
                  (value) async {
                    await store.getWallet();
                    await store.updatePrice();
                    await store.totalValue();
                    Modular.to.pushReplacementNamed('/home/wallet/');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
