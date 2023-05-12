import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:mycrypto/app/core/models/coin_search_model.dart';
import 'package:mycrypto/app/modules/wallet/stores/search_store.dart';
import 'package:mycrypto/app/modules/wallet/stores/wallet_store.dart';
import 'package:mycrypto/app/shared/widgets/image_coin_widget.dart';

class SearchBarCoinWidget extends SearchDelegate {
  final SearchStore store = Modular.get();
  final WalletStore walletStore = Modular.get();

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
        primary: Theme.of(context).colorScheme.primary,
        secondary: theme.colorScheme.secondary,
        tertiary: Color(0xff858585),
        surface: Colors.white,
        onBackground: Color(0xff858585),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Busque por uma criptomoeda';

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
  Widget buildSuggestions(BuildContext context) {
    List<CoinSearchModel> suggestionList = [];

    suggestionList = store.state
        .where((element) =>
            element.name!.toLowerCase().contains(query.toLowerCase()) ||
            element.symbol!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView.separated(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            minVerticalPadding: 0,
            onTap: () async {
              Modular.to.pushReplacementNamed(
                '/home/wallet/add',
                arguments: suggestionList[index],
              );
              close(context, null);
            },
            leading: ImageCoinWidget(
              size: 40,
              url: suggestionList[index].large!,
            ),
            title: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      suggestionList[index].name!,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AutoSizeText(
                    suggestionList[index].symbol!.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.onBackground,
              size: 15,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Theme.of(context).colorScheme.onBackground,
            height: 0,
            thickness: 0.25,
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<CoinSearchModel> suggestionList = [];
    final ScrollController _scrollController = ScrollController();

    suggestionList = store.state
        .where((element) =>
            element.name!.toLowerCase().contains(query.toLowerCase()) ||
            element.symbol!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (query.isEmpty && suggestionList.isEmpty) {
      log('Nenhum resultado encontrado');
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
        child: Scrollbar(
          controller: _scrollController,
          child: ListView.separated(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return ListTile(
                minVerticalPadding: 0,
                onTap: () async {
                  log('onTap ');
                  Modular.to.pushReplacementNamed(
                    '/home/wallet/add',
                    arguments: suggestionList[index],
                  );
                  close(context, null);
                },
                leading: ImageCoinWidget(
                  size: 40,
                  url: suggestionList[index].large!,
                ),
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          suggestionList[index].name!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AutoSizeText(
                          suggestionList[index].symbol!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 15,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Theme.of(context).colorScheme.onBackground,
                height: 0,
                thickness: 0.25,
              );
            },
          ),
        ),
      );
    }
  }
}
