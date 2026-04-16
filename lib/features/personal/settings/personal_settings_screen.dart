import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/local/shared_prefs_helper.dart';

class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({super.key});

  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _bannerAdsEnabled = true;
  bool _shareAnalytics = true;

  Future<void> _logout() async {
    await SharedPrefsHelper.clearUserSession();
    if (mounted) {
      context.go('/login-method');
    }
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Akun'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus akun? Semua data aktivitas Anda akan hilang permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Akun dihapus (Demo - Phase 2)'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Personal'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.personalGradient,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.personalSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.person, size: 28, color: AppColors.personalPrimary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal User',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'user@gmail.com',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit profil (Phase 2)')),
                    );
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Notifications
          SwitchListTile(
            title: const Text('Notifikasi'),
            subtitle: const Text('Terima notifikasi pengingat'),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.personalSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications, color: AppColors.personalPrimary, size: 20),
            ),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value ? 'Notifikasi diaktifkan' : 'Notifikasi dinonaktifkan')),
              );
            },
          ),

          const Divider(),

          // Banner Ads
          SwitchListTile(
            title: const Text('Iklan Banner'),
            subtitle: const Text('Tampilkan iklan banner di aplikasi'),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.personalSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.ads_click, color: AppColors.personalPrimary, size: 20),
            ),
            value: _bannerAdsEnabled,
            onChanged: (value) {
              setState(() => _bannerAdsEnabled = value);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value ? 'Iklan banner ditampilkan' : 'Iklan banner disembunyikan')),
              );
            },
          ),

          const Divider(),

          // Share Analytics
          SwitchListTile(
            title: const Text('Bagikan Data Analitik'),
            subtitle: const Text('Bantu kami meningkatkan aplikasi'),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.personalSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.analytics, color: AppColors.personalPrimary, size: 20),
            ),
            value: _shareAnalytics,
            onChanged: (value) {
              setState(() => _shareAnalytics = value);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value ? 'Analitik diaktifkan' : 'Analitik dinonaktifkan')),
              );
            },
          ),

          const Divider(),

          // Data Export
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.personalSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.download, color: AppColors.personalPrimary, size: 20),
            ),
            title: const Text('Ekspor Data Saya'),
            subtitle: const Text('Download semua data aktivitas'),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur ekspor data akan tersedia di Phase 6')),
              );
            },
          ),

          const Divider(),

          // Delete Account
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_forever, color: Colors.red, size: 20),
            ),
            title: const Text('Hapus Akun', style: TextStyle(color: Colors.red)),
            subtitle: const Text('Hapus semua data dan akun secara permanen'),
            trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.red),
            onTap: _showDeleteAccountDialog,
          ),

          const SizedBox(height: 24),

          // Logout button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Logout', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}