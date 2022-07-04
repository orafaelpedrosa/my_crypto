import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoLogoWidget extends StatelessWidget {
  final String? logoFormat;
  final String? logoUrl;
  final double height;
  final double width;

  const CryptoLogoWidget({
    required this.logoFormat,
    required this.logoUrl,
    this.height = 40,
    this.width = 40,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return logoFormat == 'svg'
        ? CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.network(
              logoUrl!,
              height: height,
              width: width,
            ),
          )
        : logoFormat == 'null'
            ? CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.attach_money_outlined,
                  color: Colors.white54,
                ),
              )
            : ClipOval(
                child: SizedBox.fromSize(
                  size: Size(width, height),
                  child: Image.network(
                    logoUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              );
  }
}
