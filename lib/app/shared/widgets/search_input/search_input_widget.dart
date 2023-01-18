// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  final String? label;
  final bool autocorrect;
  final bool readOnly;
  final bool isEnabled;
  final FocusNode? focusNode;
  final bool autoFocus;
  final String? placeholder;
  final String? errorText;
  final String? hintText;
  final EdgeInsets? padding;
  final bool enableSuggestions;
  final bool obscureText;
  final Function(String?)? onChange;
  final Function()? onTap;
  final TextEditingController controller;
  final int? maxLines;
  final int minLines;
  final IconData? iconData;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final bool? showCursor;

  const SearchInputWidget({
    Key? key,
    this.label,
    this.placeholder,
    this.errorText,
    this.hintText,
    this.focusNode,
    this.autoFocus = false,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.readOnly = false,
    this.isEnabled = true,
    required this.controller,
    this.onChange,
    this.onTap,
    this.padding,
    this.maxLines = 1,
    this.iconData,
    this.prefixIcon,
    this.suffixIcon,
    this.minLines = 1,
    this.textInputAction,
    this.keyboardType,
    this.showCursor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).backgroundColor,
      ),
      child: TextField(
        enableSuggestions: false,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.none,
        controller: controller,
        onChanged: onChange,
        style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_sharp,
            color: Theme.of(context).primaryColor,
          ),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.headline5!.copyWith(
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.25,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.25,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}
