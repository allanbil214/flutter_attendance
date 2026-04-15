import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class JoinKegiatanDialog {
  static Future<String?> show(BuildContext context) async {
    final otpController = TextEditingController();
    String? otpCode;

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Join Kegiatan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.qr_code, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            const Text(
              'Masukkan kode OTP dari admin untuk bergabung',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                hintText: 'Kode OTP (6 digit)',
                prefixIcon: Icon(Icons.qr_code),
              ),
              maxLength: 6,
              keyboardType: TextInputType.number,
              onChanged: (value) => otpCode = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (otpCode != null && otpCode!.length == 6) {
                Navigator.pop(context, otpCode);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kode OTP harus 6 digit')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}