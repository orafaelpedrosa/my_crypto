import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/cryptocurrency_list_widget.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/crypto_favorite_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/list_cryptocurrencies_store.dart';
import 'package:mycrypto/app/shared/widgets/search_input/search_input_widget.dart';

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
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocus = FocusNode();
  final CryptoFavoriteStore cryptoFavoriteStore = Modular.get();

  @override
  void initState() {
    store.getListCryptocurrencies();
    cryptoFavoriteStore.startFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset(
            'assets/app/mycrypto.svg',
            color: Colors.white,
            height: 25,
            width: 25,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 1,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            SizedBox(height: 5),
            SearchInputWidget(
              controller: _searchController,
              focusNode: _searchFocus,
              hintText: 'Pesquise uma criptomoeda',
              enableSuggestions: false,
              autocorrect: false,
              onChange: (value) {
                if (value != '') {
                  store.searchCrypto(value!);
                  store.search = true;
                } else {
                  store.search = false;
                  store.updateState(store.listCrypto);
                }
              },
            ),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            CryptocurrencyListWidget(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Theme.of(context).primaryColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.grey[700]!,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                    style: GnavStyle.oldSchool,
                    textStyle: Theme.of(context).textTheme.headline6!,
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favoritas',
                    textStyle: Theme.of(context).textTheme.headline6!,
                  ),
                  GButton(
                    icon: Icons.wallet,
                    text: 'Carteira',
                    textStyle: Theme.of(context).textTheme.headline6!,
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Perfil',
                    textStyle: Theme.of(context).textTheme.headline6!,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {},
              ),
            ),
          ),
        ),
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
