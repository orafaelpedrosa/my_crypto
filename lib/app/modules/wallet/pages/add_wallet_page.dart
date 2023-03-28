import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';
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
  final TextEditingController priceAverage = TextEditingController();

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
      body: Column(
        children: [
          TextFormFieldWidget(
            controller: amountController,
            hintText: 'Quantidade',
            keyboardType: TextInputType.number,
            onChange: (value) {
            },
          ),
        ],
      ),
    );
  }
}
