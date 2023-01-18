import 'package:flutter/material.dart';

openErrorSnackBar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).backgroundColor,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Theme.of(context).backgroundColor,
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
            color: Colors.black,
          ),
          SizedBox(width: 15),
          Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black,
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
            color: Theme.of(context).backgroundColor,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).backgroundColor,
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
