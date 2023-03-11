import 'package:flutter/material.dart';

openErrorSnackBar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ],
      ),
      duration: Duration(
        seconds: 3,
      ),
    ),
  );
}

openWarningSnackBar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.yellow,
      content: Row(
        children: [
          Icon(
            Icons.warning,
            color: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(width: 15),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
      duration: Duration(
        seconds: 3,
      ),
    ),
  );
}

openSucessSnackBar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.background,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
        ],
      ),
      duration: Duration(
        seconds: 3,
      ),
    ),
  );
}
