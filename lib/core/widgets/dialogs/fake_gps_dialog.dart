import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class FakeGpsDialog {
  static void show(BuildContext context, {VoidCallback? onExit}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.gps_off, color: Colors.red, size: 28),
            const SizedBox(width: 12),
            const Text('Fake GPS Terdeteksi'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              'Aplikasi mendeteksi penggunaan Fake GPS / Mock Location.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Silakan nonaktifkan Fake GPS untuk melanjutkan presensi.',
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