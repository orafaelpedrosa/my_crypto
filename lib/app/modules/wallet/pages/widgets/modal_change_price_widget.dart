import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:mycrypto/app/core/shared/widgets/button/button_primary_widget.dart';

class ModalChangePriceWidget extends StatefulWidget {
  const ModalChangePriceWidget({Key? key}) : super(key: key);

  @override
  State<ModalChangePriceWidget> createState() => _ModalChangePriceWidgetState();
}

class _ModalChangePriceWidgetState extends State<ModalChangePriceWidget> {
  WalletStore walletStore = Modular.get();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RegExp numberRegExp = RegExp(r'^\d+\.?\d{0,2}');
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TextFormField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(numberRegExp),
                ],
                decoration: InputDecoration(
                  hintText:
                      walletStore.cryptoModel.currentPrice!.toStringAsFixed(2),
                  filled: true,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(0.15),
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.monetization_on_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ButtonPrimaryWidget(
                    isLoading: false,
                    text: 'Confirmar',
                    onPressed: () async {
                      walletStore.cryptoModel.currentPrice = double.parse(
                        _controller.text,
                      );
                      walletStore.updateState();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
