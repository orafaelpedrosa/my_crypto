import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/search_bar_widget.dart';
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
  // TextEditingController _searchController = TextEditingController();
  // FocusNode _searchFocus = FocusNode();
  final FavoritesStore favoritesStore = Modular.get();

  @override
  void initState() {
    store.getListCryptocurrencies();
    favoritesStore.startFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset(
            'assets/app/mycrypto.svg',
            color: Theme.of(context).primaryColor,
            height: 25,
            width: 25,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 1,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                // loginStore.authLogout();
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
              CryptocurrencyListWidget(),
            ],
          ),
        ),
        // body: Column(
        //   children: [
        //     SizedBox(height: 5),
        //     SearchInputWidget(
        //       controller: _searchController,
        //       focusNode: _searchFocus,
        //       hintText: 'Pesquise uma criptomoeda',
        //       enableSuggestions: false,
        //       autocorrect: false,
        //       onChange: (value) {
        //         if (value != '') {
        //           store.searchCrypto(value!);
        //           store.search = true;
        //         } else {
        //           store.search = false;
        //           store.updateState(store.listCrypto);
        //         }
        //       },
        //     ),
        //     Divider(
        //       color: Colors.black12,
        //       thickness: 1,
        //     ),
        //     CryptocurrencyListWidget(),
        //   ],
        // ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     loginStore.authLogout();
        //   },
        //   child: Icon(Icons.logout),
        // ),
      ),
    );
  }
}
