import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycrypto/app/shared/widgets/button/button_primary_widget.dart';

class ModalChangePriceWidget extends StatefulWidget {
  const ModalChangePriceWidget({Key? key}) : super(key: key);

  @override
  State<ModalChangePriceWidget> createState() => _ModalChangePriceWidgetState();
}

class _ModalChangePriceWidgetState extends State<ModalChangePriceWidget> {
  @override
  Widget build(BuildContext context) {
    final RegExp numberRegExp = RegExp(r'\d');
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              //regex de numeros
              inputFormatters: [
                FilteringTextInputFormatter.allow(numberRegExp),
              ],

              decoration: InputDecoration(
                hintText: 'Preço',
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.background.withOpacity(0.15),
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
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
