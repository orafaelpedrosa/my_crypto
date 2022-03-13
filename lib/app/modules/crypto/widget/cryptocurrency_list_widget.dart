import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_store.dart';

class BleDevicesListWidget extends StatefulWidget {
  BleDevicesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _BleDevicesListWidgetState createState() => _BleDevicesListWidgetState();
}

class _BleDevicesListWidgetState extends State<BleDevicesListWidget> {
  CryptocurrencyStore store = Modular.get();

  @override
  void initState() {
    store.getCrypto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CryptocurrencyModel>>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) {
          return store.state;
        },
      ),
      initialData: const [],
      builder: (context, snapshot) {
        return ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: snapshot.data!
              .map(
                (coin) => Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: ListTile(
                    title: Text('a'),
                    subtitle: Text('fb'),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.money,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
