import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mycrypto/app/core/enums/error_type_enum.dart';
import 'package:mycrypto/app/core/shared/widgets/button/button_primary_widget.dart';

// ignore: must_be_immutable
class ErrorHttpWidget extends StatefulWidget {
  final String error;
  ErrorHttpEnum? errorType;
  Function()? onTap;
  String? title;
  String? subtitle;

  ErrorHttpWidget({
    Key? key,
    required this.error,
    this.errorType,
    this.onTap,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  State<ErrorHttpWidget> createState() => _ErrorHttpWidgetState();
}

class _ErrorHttpWidgetState extends State<ErrorHttpWidget> {
  @override
  void initState() {
    switch (widget.error) {
      case '401':
        widget.errorType = ErrorHttpEnum.e401;
        break;
      case '404':
        widget.errorType = ErrorHttpEnum.e404;
        break;
      case '403':
        widget.errorType = ErrorHttpEnum.e403;
        break;
      case '429':
        widget.errorType = ErrorHttpEnum.e429;
        break;
      default:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            widget.errorType?.assetError ?? 'assets/error/error_http.svg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 10),
          Text(
            widget.title ?? 'Ops! Algo deu errado.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 10),
          Text(
            widget.subtitle ??
                'Infelizmente não foi possível atender a sua solicitação.',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ButtonPrimaryWidget(
            isLoading: false,
            text: 'Tentar novamente',
            onPressed: widget.onTap ?? () {},
          ),
        ],
      ),
    );
  }
}
