import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/datasources/local/shared_prefs_helper.dart';
import '../../data/datasources/remote/api_client.dart';

/// Single source of truth for logout logic.
/// Handles API call, session clearing (all roles), and navigation.
class LogoutService {
  static Future<void> logout(BuildContext context) async {
    // 1. Call the API (fire-and-forget — we log out locally regardless)
    try {
      await ApiClient().logout();
    } catch (_) {}

    // 2. Clear ALL sessions so no stale flags remain across role switches
    await SharedPrefsHelper.clearUserSession();
    await SharedPrefsHelper.clearAdminSession();
    await SharedPrefsHelper.clearPersonalSession();

    // 3. Navigate + feedback
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda telah logout'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/login-method');
    }
  }

  /// Shows the confirmation dialog, then calls [logout] on confirm.
  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await logout(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
