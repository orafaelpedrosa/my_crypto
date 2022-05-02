import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/theme/colors.dart';

class CryptoDetailsPage extends StatefulWidget {
  const CryptoDetailsPage({Key? key}) : super(key: key);

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Details'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Center(
        child: Text('Crypto Details'),
      ),
    );
  }
}
