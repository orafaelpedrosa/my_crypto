import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/cryptocurrency_simple_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';

class SearchBarWidget extends SearchDelegate {
  final ListCryptocurrenciesStore store = Modular.get();
  final FavoritesStore favoritesStore = Modular.get();
  final LoginStore loginStore = Modular.get();

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: theme.primaryIconTheme
            .copyWith(color: Theme.of(context).colorScheme.primary),
        elevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
      colorScheme: ColorScheme(
        background: const Color(0xff050409),
        brightness: Brightness.dark,
        error: Colors.red,
        onError: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        primary: const Color(0xff5865F2),
        secondary: Colors.white,
        tertiary: Color(0xff858585),
        surface: Colors.white,
        onBackground: Color(0xff858585),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<CryptocurrencySimpleModel> suggestionList = query.isEmpty
        ? store.state
        : store.state
            .where((element) =>
                element.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
    if (query.isEmpty || suggestionList.isEmpty) {
      return Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Text(
            'Nenhum resultado encontrado',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
    } else {
      return Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return ListTile(
              minVerticalPadding: 0,
              onTap: () {
                close(context, null);
                Modular.to.pushNamed(
                  '/cryptocurrency/details',
                  arguments: suggestionList[index],
                );
              },
              leading: ClipOval(
                child: SizedBox.fromSize(
                  size: Size(40, 40),
                  child: Image.network(
                    suggestionList[index].image!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
              title: Text(
                suggestionList[index].name!,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              trailing: TripleBuilder<FavoritesStore, Exception,
                  List<CryptocurrencySimpleModel>>(
                store: favoritesStore,
                builder: (_, triple) {
                  log('toggle ${store.isLoading}');

                  return store.isLoading
                      ? CircularProgressIndicator()
                      : IconButton(
                          icon: favoritesStore.isFavorite(suggestionList[index])
                              ? Icon(Icons.star_rate_rounded)
                              : Icon(Icons.star_border_rounded),
                          onPressed: () {
                            favoritesStore
                                .toggleFavorite(suggestionList[index]);
                          },
                        );
                },
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? store.state
        : store.state
            .where((element) =>
                element.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            minVerticalPadding: 0,
            onTap: () {
              close(context, null);
              Modular.to.pushNamed('/home/cryptocurrency/details', arguments: {
                'cryptocurrency': suggestionList[index],
                'fromFavorite': false
              });
            },
            leading: ClipOval(
              child: SizedBox.fromSize(
                size: Size(40, 40),
                child: Image.network(
                  suggestionList[index].image!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            title: Text(
              suggestionList[index].name!,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            trailing: TripleBuilder<FavoritesStore, Exception,
                List<CryptocurrencySimpleModel>>(
              store: favoritesStore,
              builder: (_, triple) {
                return store.isLoading
                    ? CircularProgressIndicator()
                    : IconButton(
                        icon: favoritesStore.isFavorite(suggestionList[index])
                            ? Icon(Icons.star_rate_rounded)
                            : Icon(Icons.star_outline_rounded),
                        onPressed: () {
                          favoritesStore.toggleFavorite(suggestionList[index]);
                        },
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
