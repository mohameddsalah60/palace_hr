import 'package:flutter/material.dart';

customSnackBar({
  required BuildContext context,
  required String message,
  Color color = Colors.red,
}) {
  // Custom SnackBar widget
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

  // Custom SnackBar widget

