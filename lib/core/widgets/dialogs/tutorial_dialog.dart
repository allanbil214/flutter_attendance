import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class TutorialDialog {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Panduan Tutorial',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // YouTube option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.play_arrow, color: Colors.red),
              ),
              title: const Text('Video Tutorial YouTube'),
              subtitle: const Text('Tonton video panduan lengkap'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                // TODO: Open YouTube
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Membuka YouTube... (Phase 2)')),
                );
              },
            ),
            
            // PDF option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.picture_as_pdf, color: Colors.blue),
              ),
              title: const Text('Manual Book PDF'),
              subtitle: const Text('Download panduan dalam format PDF'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                // TODO: Download PDF
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mengunduh PDF... (Phase 2)')),
                );
              },
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}