import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class UpdateAvailableDialog {
  static void show(
    BuildContext context, {
    required String currentVersion,
    required String latestVersion,
    required bool forceUpdate,
    VoidCallback? onUpdate,
  }) {
    showDialog(
      context: context,
      barrierDismissible: !forceUpdate,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.system_update, color: AppColors.warning, size: 28),
            const SizedBox(width: 12),
            const Text('Update Tersedia'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.downloading, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              'Versi baru aplikasi tersedia!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Versi saat ini: $currentVersion\nVersi terbaru: $latestVersion',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            if (forceUpdate)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Update WAJIB untuk melanjutkan',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
          ],
        ),
        actions: [
          if (!forceUpdate)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Nanti'),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (onUpdate != null) onUpdate();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Update Sekarang'),
          ),
        ],
      ),
    );
  }
}