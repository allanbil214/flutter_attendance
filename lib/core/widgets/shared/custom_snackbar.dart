import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.green,
    IconData icon = Icons.check_circle,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: duration,
      ),
    );
  }

  static void success(BuildContext context, String message) {
    show(context: context, message: message, backgroundColor: Colors.green);
  }

  static void error(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static void warning(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }

  static void info(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }
}