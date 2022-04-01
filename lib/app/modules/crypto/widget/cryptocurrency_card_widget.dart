// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CryptocurrencyCardWidget extends StatefulWidget {
  String? crypto_name;
  String? crypto_symbol;
  double? crypto_price;
  String? crypto_rank;
  String? crypto_logo_url;
  String? imageFormat;

  CryptocurrencyCardWidget({
    Key? key,
    this.crypto_name,
    this.crypto_symbol,
    this.crypto_price,
    this.crypto_rank,
    this.crypto_logo_url,
    this.imageFormat,
  }) : super(key: key);

  @override
  State<CryptocurrencyCardWidget> createState() => _CryptocurrencyCardWidgetState();
}

class _CryptocurrencyCardWidgetState extends State<CryptocurrencyCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: widget.imageFormat == 'svg'
                ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.network(
                      widget.crypto_logo_url!,
                      height: 35,
                      width: 35,
                    ),
                  )
                : widget.imageFormat == 'null'
                    ? CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.black54,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.transparent,
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
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                    color: Colors.black54.withOpacity(0.05),
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
            trailing: Text(
              '\$ ${widget.crypto_price!.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
