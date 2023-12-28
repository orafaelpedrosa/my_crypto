import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/enums/operation_historic_enum.dart';
import 'package:mycrypto/app/core/services/formatters_services.dart';
import 'package:mycrypto/app/core/shared/widgets/app_bar_widget.dart';
import 'package:mycrypto/app/modules/wallet/models/transaction_model.dart';
import 'package:mycrypto/app/modules/wallet/stores/transaction_history_store.dart';

class TransactionHistoryPage extends StatefulWidget {
  final String? id;
  TransactionHistoryPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  DateTime _date = DateTime.now();
  TransactionHistoryStore store = Modular.get();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id != null) {
        store.getHistoricByID(widget.id!);
      } else {
        store.getAllHistoricByWallet();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBarWidget(
        title: 'Transações',
        actions: [
          IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2021),
                lastDate: DateTime.now(),
              ).then((value) async {
                if (value != null) {
                  setState(() {
                    _date = value;
                  });
                  store.getHistoricByDate(value);
                }
              });
            },
            icon: Icon(
              Icons.calendar_month_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          IconButton(
            onPressed: () {
              store.clear();
            },
            icon: Icon(
              Icons.cleaning_services_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ).build(context) as AppBar,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: TripleBuilder<TransactionHistoryStore,
            List<TransactionHistoryModel>>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (triple.state.isEmpty) {
              return Center(
                child: Text(
                  'Nenhuma transação encontrada!',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 0.5,
              ),
              padding: EdgeInsets.zero,
              itemCount: store.state.length,
              itemBuilder: (_, index) {
                final item = store.state[index];
                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                  // leading: CircleAvatar(
                  //   backgroundColor: item.operation == OperationHistoricEnum.add
                  //       ? Colors.green
                  //       : Colors.red,
                  //   child: Icon(
                  //     item.operation == OperationHistoricEnum.add
                  //         ? Icons.add
                  //         : Icons.remove,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  leading: Icon(
                    item.operation == OperationHistoricEnum.add
                        ? Icons.add
                        : Icons.remove,
                    color: item.operation == OperationHistoricEnum.add
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(item.name!),
                  subtitle: Text(
                    FormattersServices.formatDateBR(item.date!),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.operation == OperationHistoricEnum.add
                            ? '+ ${item.value}'
                            : '- ${item.value}',
                      ),
                      Expanded(
                        child: Text(
                          item.operation == OperationHistoricEnum.remove
                              ? FormattersServices.priceInCurrencyFormat(
                                  '- ${item.purchasePrice!.toStringAsFixed(2)}')
                              : FormattersServices.priceInCurrencyFormat(
                                  '${item.purchasePrice!.toStringAsFixed(2)}'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
