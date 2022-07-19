import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/cryptocurrency/pages/widgets/cryptocurrency_list_widget.dart';
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

  @override
  void initState() {
    store.getListCryptocurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.975),
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
          SizedBox(height: 10),
          CryptocurrencyListWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loginStore.authLogout();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
