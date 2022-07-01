import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/modules/crypto/pages/widget/crypto_list_widget.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_list_store.dart';
import 'package:mycrypto/app/shared/widgets/search_input/search_input_widget.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends ModularState<CryptoPage, CryptoListStore> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/app/mycrypto.svg',
          color: Theme.of(context).primaryColor,
          height: 25,
          width: 25,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          SearchInputWidget(
            textController: _searchController,
            hintText: 'Pesquise uma criptomoeda',
            onChange: (value) {
              store.searchCrypto(value!);
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: const CryptocurrencyListWidget(),
          ),
        ],
      ),
    );
  }
}
