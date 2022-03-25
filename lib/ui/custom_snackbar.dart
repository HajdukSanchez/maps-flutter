import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    Key? key,
    required String message,
    Duration duration = const Duration(seconds: 3),
    String buttonLabel = 'OK',
    VoidCallback? onPressed,
  }) : super(
            key: key,
            content: Text(message),
            duration: duration,
            action: SnackBarAction(
                label: buttonLabel,
                onPressed: () {
                  if (onPressed != null) {
                    onPressed();
                  }
                }));
}
