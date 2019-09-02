import 'package:flutter/material.dart';

SnackBar getSnackBarLoad(textValue, page) {
  return  SnackBar(
    content: Text(textValue),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
