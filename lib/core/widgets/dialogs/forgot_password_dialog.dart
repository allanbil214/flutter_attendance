import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class ForgotPasswordDialog {
  static Future<String?> show(BuildContext context) async {
    final emailController = TextEditingController();
    String? email;

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_reset, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            const Text(
              'Masukkan email Anda untuk menerima link reset password',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
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
              if (email != null && email!.isNotEmpty) {
                Navigator.pop(context, email);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email tidak boleh kosong')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }
}