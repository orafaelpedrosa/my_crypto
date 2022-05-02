// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CryptoCardWidget extends StatefulWidget {
  String? crypto_name;
  String? crypto_symbol;
  double? crypto_price;
  String? crypto_rank;
  String? crypto_logo_url;
  String? crypto_price_date;
  String? imageFormat;

  CryptoCardWidget({
    Key? key,
    this.crypto_name,
    this.crypto_symbol,
    this.crypto_price,
    this.crypto_rank,
    this.crypto_logo_url,
    this.crypto_price_date,
    this.imageFormat,
  }) : super(key: key);

  @override
  State<CryptoCardWidget> createState() => _CryptocurrencyCardWidgetState();
}

class _CryptocurrencyCardWidgetState extends State<CryptoCardWidget> {
  @override
  Widget build(BuildContext context) {
    double _cryptoPrice = double.parse(widget.crypto_price_date!) * 100;

    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          'crypto_details',
        );
      },
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: widget.imageFormat == 'svg'
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.network(
                        widget.crypto_logo_url!,
                        height: 50,
                        width: 50,
                      ),
                    )
                  : widget.imageFormat == 'null'
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.attach_money_outlined,
                            color: Colors.white54,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            widget.crypto_logo_url!,
                            scale: 0.1,
                          ),
                        ),
              title: Text(
                widget.crypto_name!,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w500,
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
                        widget.crypto_rank!,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.crypto_symbol!,
                    style: TextStyle(
                      color: Colors.black,
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
                    '\$ ${widget.crypto_price}',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.crypto_price_date!.contains('-')
                        ? '${_cryptoPrice.toStringAsFixed(2)}%'
                        : '+${_cryptoPrice.toStringAsFixed(2)}%',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: _cryptoPrice > 0
                              ? Colors.green
                              : _cryptoPrice < 0
                                  ? Colors.red
                                  : Colors.black,
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
