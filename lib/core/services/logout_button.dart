import 'package:flutter/material.dart';
import 'logout_service.dart';

/// Drop-in logout button — put it in any AppBar actions or as a ListTile.
///
/// Usage in AppBar:
///   actions: [const LogoutButton()]
///
/// Usage as a list tile (e.g. settings / profile):
///   LogoutButton.tile()
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () => LogoutService.showLogoutDialog(context),
    );
  }

  /// A styled ListTile variant for settings/profile screens.
  static Widget tile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text(
        'Logout',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
      ),
      onTap: () => LogoutService.showLogoutDialog(context),
    );
  }
}
