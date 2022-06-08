// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycrypto/app/core/model/cryptocurrency_model.dart';
import 'package:mycrypto/app/modules/crypto/pages/widget/crypto_logo_widget.dart';
import 'package:mycrypto/app/modules/crypto/stores/crypto_store.dart';

class CryptoCardWidget extends StatefulWidget {
  final CryptocurrencyModel cryptoModel;

  CryptoCardWidget({
    Key? key,
    required this.cryptoModel,
  }) : super(key: key);

  @override
  State<CryptoCardWidget> createState() => _CryptocurrencyCardWidgetState();
}

class _CryptocurrencyCardWidgetState extends State<CryptoCardWidget> {
  CryptoStore cryptoStore = Modular.get<CryptoStore>();

  @override
  Widget build(BuildContext context) {
    double _cryptoPrice =
        double.parse(widget.cryptoModel.priceDay!.priceChangePct!) * 100;

    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('crypto_details', arguments: widget.cryptoModel);
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CryptoLogoWidget(
                logoFormat: widget.cryptoModel.logoFormat,
                logoUrl: widget.cryptoModel.logoUrl,
                width: 40,
                height: 40,
              ),
              title: Text(
                widget.cryptoModel.name!,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        widget.cryptoModel.rank!,
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.cryptoModel.symbol!,
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${widget.cryptoModel.price}',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.cryptoModel.priceDay!.priceChangePct!.contains('-')
                        ? '${_cryptoPrice.toStringAsFixed(2)}%'
                        : '+${_cryptoPrice.toStringAsFixed(2)}%',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: _cryptoPrice > 0
                              ? Colors.green
                              : _cryptoPrice < 0
                                  ? Colors.red
                                  : Colors.blue,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
