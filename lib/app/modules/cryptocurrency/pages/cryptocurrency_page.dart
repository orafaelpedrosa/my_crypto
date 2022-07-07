import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/cryptocurrency_store.dart';

class CryptocurrencyPage extends StatefulWidget {
  final String title;
  const CryptocurrencyPage({Key? key, this.title = 'CryptocurrencyPage'}) : super(key: key);
  @override
  CryptocurrencyPageState createState() => CryptocurrencyPageState();
}
class CryptocurrencyPageState extends State<CryptocurrencyPage> {
  final CryptocurrencyStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}