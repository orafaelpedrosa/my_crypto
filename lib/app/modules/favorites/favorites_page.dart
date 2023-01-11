import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/favorites/favorites_store.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final String title;
  const FavoritesPage({Key? key, this.title = 'FavoritesPage'})
      : super(key: key);
  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  final FavoritesStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
