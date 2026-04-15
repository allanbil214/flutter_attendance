import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class PhotoZoomDialog {
  static void show(
    BuildContext context, {
    required String imageUrl,
    VoidCallback? onDelete,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image area
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 64, color: Colors.grey.shade400),
                ),
              ),
              
              // Action buttons
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Tutup'),
                    ),
                    if (onDelete != null)
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text('Hapus', style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}