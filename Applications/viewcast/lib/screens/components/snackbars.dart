import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String label) {
  var snackBar = SnackBar(
    backgroundColor: Colors.lightGreen,
    content: Text(
      label,
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorSnackBar(BuildContext context, String label) {
  var snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      label,
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
