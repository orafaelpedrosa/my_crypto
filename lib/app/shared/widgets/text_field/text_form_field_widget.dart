import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
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
  final Icon? iconData;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final bool? showCursor;

  const TextFormFieldWidget({
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
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Colors.black54,
            fontSize: 16,
          ),
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.red,
              fontSize: 12,
            ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black54,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        prefixIcon: iconData,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Colors.black54,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
