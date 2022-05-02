import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/core/theme/colors.dart';
import 'package:mycrypto/app/modules/crypto/stores/cryptocurrency_store.dart';
import 'package:mycrypto/app/modules/crypto/widget/crypto_list_widget.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  CryptocurrencyStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: SvgPicture.asset(
            'assets/app/mycrypto.svg',
            color: Colors.white,
            height: 32,
            width: 32,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const CryptocurrencyListWidget(),
    );
  }
}
