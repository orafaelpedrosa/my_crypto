import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageCoinWidget extends StatefulWidget {
  final double size;
  final String url;
  const ImageCoinWidget({
    Key? key,
    required this.size,
    required this.url,
  }) : super(key: key);

  @override
  State<ImageCoinWidget> createState() => _ImageCoinWidgetState();
}

class _ImageCoinWidgetState extends State<ImageCoinWidget> {
  String getFormatImage(String? url) {
    if (url == null || url.isEmpty || url == 'null' || url == '') {
      return 'null';
    } else {
      int ponto = url.lastIndexOf('.');
      String imageFormat = url.substring(ponto + 1, url.length);
      return imageFormat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String format = getFormatImage(widget.url);

    return format != 'null'
        ? format.contains('svg')
            ? SvgPicture.network(
                widget.url,
                width: widget.size,
                height: widget.size,
              )
            : ClipOval(
                child: SizedBox.fromSize(
                  size: Size(widget.size, widget.size),
                  child: widget.url != ''
                      ? Image.network(
                          widget.url,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator.adaptive(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                  strokeWidth: 1.5,
                                ),
                              );
                            }
                          },
                        )
                      : Icon(
                          Icons.monetization_on,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 35,
                        ),
                ),
              )
        : Icon(
            Icons.monetization_on,
            color: Theme.of(context).colorScheme.secondary,
            size: 35,
          );
  }
}
