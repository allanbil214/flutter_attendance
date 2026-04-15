import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class InternetErrorDialog {
  static void show(BuildContext context, {VoidCallback? onRetry}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Koneksi Error'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Tidak dapat terhubung ke internet'),
            SizedBox(height: 8),
            Text(
              'Periksa koneksi internet Anda',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          if (onRetry != null)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onRetry();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Coba Lagi'),
            ),
        ],
      ),
    );
  }
}