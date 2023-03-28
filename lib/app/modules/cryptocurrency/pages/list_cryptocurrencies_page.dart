import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/search_bar_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/tabs_filter_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/modules/favorites/stores/favorites_store.dart';

class ListCryptocurrenciesPage extends StatefulWidget {
  final String title;
  const ListCryptocurrenciesPage(
      {Key? key, this.title = 'ListCryptocurrenciesPage'})
      : super(key: key);
  @override
  CryptocurrencyPageState createState() => CryptocurrencyPageState();
}

class CryptocurrencyPageState extends State<ListCryptocurrenciesPage> {
  final ListCryptocurrenciesStore store = Modular.get();
  final LoginStore loginStore = Modular.get();
  final FavoritesStore favoritesStore = Modular.get();

  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void initState() {
    store.marketsParams.order = 'market_cap_desc';
    store.marketsParams.perPage = 250;
    store.marketsParams.page = 1;
    store.marketsParams.sparkline = 'true';
    store.marketsParams.priceChangePercentage = '24h';
    store.marketsParams.vsCurrency = 'brl';
    store.getListCryptocurrencies();
    favoritesStore.startFavorites();
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showButton = _scrollController.offset > 100;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset(
            'assets/app/mycrypto.svg',
            height: 25,
            width: 25,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 2,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchBarWidget(),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabsFilterListWidget(),
              CryptocurrencyListWidget(scrollController: _scrollController),
            ],
          ),
        ),
        floatingActionButton: _showButton
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: Icon(
                  Icons.arrow_upward,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : null,
      ),
    );
  }
}
