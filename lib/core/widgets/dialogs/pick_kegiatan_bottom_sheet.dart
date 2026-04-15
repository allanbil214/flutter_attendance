import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';

class PickKegiatanBottomSheet {
  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    required List<Map<String, dynamic>> kegiatanList,
  }) async {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              'Pilih Kegiatan Aktif',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pilih kegiatan yang akan Anda lakukan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Kegiatan list
            ...kegiatanList.map((kegiatan) => ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.assignment, color: AppColors.primary),
              ),
              title: Text(
                kegiatan['name'],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                '${kegiatan['location']} • ${kegiatan['checkinTime']} - ${kegiatan['checkoutTime']}',
                style: const TextStyle(fontSize: 12),
              ),
              onTap: () => Navigator.pop(context, kegiatan),
            )),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}