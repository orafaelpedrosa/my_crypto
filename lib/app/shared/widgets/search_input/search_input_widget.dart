// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String?)? onChange;

  const SearchInputWidget({
    Key? key,
    required this.textController,
    required this.hintText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.none,
        controller: textController,
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
