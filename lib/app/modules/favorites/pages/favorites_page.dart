import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final String title;
  const FavoritesPage({Key? key, this.title = 'Favoritas'}) : super(key: key);
  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  final FavoritesStore store = Modular.get();

  @override
  void initState() {
    store.getCryptocurrenciesByIDs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: TripleBuilder<FavoritesStore, Exception,
          List<CryptocurrencySimpleModel>>(
        store: store,
        builder: (context, triple) {
          if (triple.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (triple.error != null) {
            return Center(
              child: Text(triple.error.toString()),
            );
          } else {
            return ListView.builder(
              itemCount: triple.state.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(triple.state[index].name!),
                  subtitle: Text(triple.state[index].symbol!),
                );
              },
            );
          }
        },
      ),
    );
  }
}
