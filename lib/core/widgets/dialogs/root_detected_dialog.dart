import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class RootDetectedDialog {
  static void show(BuildContext context, {VoidCallback? onExit}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.security, color: Colors.red, size: 28),
            const SizedBox(width: 12),
            const Text('Perangkat Root Terdeteksi'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              'Aplikasi tidak dapat berjalan pada perangkat yang sudah di-root.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Untuk keamanan data, aplikasi akan ditutup.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (onExit != null) onExit();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Tutup Aplikasi'),
          ),
        ],
      ),
    );
  }
}