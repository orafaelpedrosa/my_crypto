// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mycrypto/app/core/enums/error_type_enum.dart';

// ignore: must_be_immutable
class ErrorHttpWidget extends StatefulWidget {
  final String error;
  ErrorHttpEnum? errorType;
  ErrorHttpWidget({
    Key? key,
    required this.error,
    this.errorType,
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
      case '429':
        widget.errorType = ErrorHttpEnum.e429;
        break;
      default:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            widget.errorType!.assetError,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          SizedBox(height: 10),
          Text(
            widget.errorType!.errorMessage,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
