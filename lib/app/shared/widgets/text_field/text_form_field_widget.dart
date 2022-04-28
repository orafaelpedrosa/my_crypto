import 'package:flutter/material.dart';
import 'package:mycrypto/app/core/theme/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? iconData;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final Function(String?)? onChange;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;

  TextFormFieldWidget({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.iconData,
    this.labelText,
    this.hintText,
    this.focusNode,
    this.onChange,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 14,
          ),
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.headline1!.copyWith(
              color: Colors.red,
              fontSize: 12,
            ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColors.primaryColor.withOpacity(0.5),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.primaryColor.withOpacity(0.5),
        ),
        prefixIcon: Icon(
          iconData,
          color: AppColors.primaryColor,
          size: 20,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
