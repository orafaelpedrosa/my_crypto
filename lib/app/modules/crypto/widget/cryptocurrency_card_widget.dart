// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CryptocurrencyCardWidget extends StatefulWidget {
  String? crypto_name;
  String? crypto_symbol;
  double? crypto_price;
  String? crypto_rank;
  String? crypto_logo_url;

  CryptocurrencyCardWidget({
    Key? key,
    this.crypto_name,
    this.crypto_symbol,
    this.crypto_price,
    this.crypto_rank,
    this.crypto_logo_url,
  }) : super(key: key);

  @override
  State<CryptocurrencyCardWidget> createState() => _CryptocurrencyCardWidgetState();
}

class _CryptocurrencyCardWidgetState extends State<CryptocurrencyCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.network(
                  widget.crypto_logo_url.toString(),
                  width: 150,
                  height: 150,
                ),
              ),
              title: Text(
                widget.crypto_name!,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        widget.crypto_rank!,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.crypto_symbol!,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                widget.crypto_price!.toStringAsFixed(2),
                style: TextStyle(
                  color: const Color(0xFF32CD32),
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
