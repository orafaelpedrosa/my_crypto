// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool? isDisabled;

  const ButtonPrimaryWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: 
          isDisabled!
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
        ),
      ),
    );
  }
}
