import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:mycrypto/app/core/shared/widgets/button/button_primary_widget.dart';

class ModalChangeTimeWidget extends StatefulWidget {
  const ModalChangeTimeWidget({Key? key}) : super(key: key);

  @override
  State<ModalChangeTimeWidget> createState() => _ModalChangeTimeWidgetState();
}

class _ModalChangeTimeWidgetState extends State<ModalChangeTimeWidget> {
  final WalletStore walletStore = Modular.get();
  DateTime _date = DateTime.now();
  void onSelectedDate(DateTime date) {
    setState(() {
      walletStore.date = date;
      walletStore.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_calendar_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Definir Data e Hora',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 120,
              child: CupertinoDatePicker(
                use24hFormat: true,
                dateOrder: DatePickerDateOrder.dmy,
                initialDateTime: walletStore.date,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (value) {
                  _date = value;
                },
                mode: CupertinoDatePickerMode.dateAndTime,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ButtonPrimaryWidget(
                    isLoading: false,
                    text: 'Confirmar',
                    onPressed: () async {
                      if (_date != walletStore.date) {
                        onSelectedDate(_date);
                      }
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
