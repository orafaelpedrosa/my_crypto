import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/core/theme/colors.dart';
import 'package:mycrypto/app/modules/crypto/widget/cryptocurrency_list_widget.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/app/mycrypto.svg',
          height: 32,
          width: 32,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: const CryptocurrencyListWidget(),
    );
  }
}
