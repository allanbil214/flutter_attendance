import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _bannerAdsEnabled = true;

  // Dummy org data
  final Map<String, dynamic> _orgData = {
    'name': 'PT Barani Multi Teknologi',
    'email': 'admin@barani.com',
    'phone': '082233445566',
    'employeeCount': 5,
    'subscription': 'Growth Plan',
    'expiresAt': '2026-09-14',
    'coinBalance': 120,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Admin'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Organization Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.adminSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informasi Organisasi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                _InfoRow(label: 'Nama', value: _orgData['name']),
                const SizedBox(height: 8),
                _InfoRow(label: 'Email', value: _orgData['email']),
                const SizedBox(height: 8),
                _InfoRow(label: 'Telepon', value: _orgData['phone']),
                const SizedBox(height: 8),
                _InfoRow(label: 'Jumlah Karyawan', value: '${_orgData['employeeCount']}'),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Paket Langganan'),
                    Text(
                      _orgData['subscription'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Berlaku hingga'),
                    Text(_orgData['expiresAt']),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Saldo Koin'),
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${_orgData['coinBalance']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/admin-organisasi'),
                    icon: const Icon(Icons.edit),
                    label: const Text('Kelola Organisasi'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Notifications
          SwitchListTile(
            title: const Text('Notifikasi'),
            subtitle: const Text('Terima notifikasi check-in karyawan'),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.adminSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications, color: AppColors.adminPrimary, size: 20),
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
                color: AppColors.adminSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.ads_click, color: AppColors.adminPrimary, size: 20),
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

          // Data Export
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.adminSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.download, color: AppColors.adminPrimary, size: 20),
            ),
            title: const Text('Ekspor Data'),
            subtitle: const Text('Download laporan dalam format CSV/PDF'),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur ekspor data akan tersedia di Phase 6')),
              );
            },
          ),

          const Divider(),

          // QRIS Top Up
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.qr_code, color: Colors.amber, size: 20),
            ),
            title: const Text('Top Up Koin'),
            subtitle: const Text('Beli koin untuk fitur premium'),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => context.push('/qris'),
          ),

          const SizedBox(height: 24),

          Text(
            'Pengaturan akan disimpan dan berlaku untuk seluruh organisasi',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}