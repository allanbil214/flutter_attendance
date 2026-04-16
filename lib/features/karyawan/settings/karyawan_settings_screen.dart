import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/shared/enterprise_badge.dart';

class KaryawanSettingsScreen extends StatefulWidget {
  const KaryawanSettingsScreen({super.key});

  @override
  State<KaryawanSettingsScreen> createState() => _KaryawanSettingsScreenState();
}

class _KaryawanSettingsScreenState extends State<KaryawanSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _backgroundTrackingEnabled = true;
  bool _bannerAdsEnabled = true;

  final String _workingHoursStart = '08:00';
  final String _workingHoursEnd = '16:00';
  final bool _isWithinWorkingHours = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Working Hours Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.blue.shade700, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'Jam Kerja',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Jadwal:', style: TextStyle(fontSize: 12)),
                    Text(
                      '$_workingHoursStart - $_workingHoursEnd',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Status Tracking:', style: TextStyle(fontSize: 12)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _isWithinWorkingHours
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isWithinWorkingHours ? Icons.play_arrow : Icons.stop,
                            size: 12,
                            color: _isWithinWorkingHours ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            _isWithinWorkingHours ? 'Aktif' : 'Tidak Aktif',
                            style: TextStyle(
                              fontSize: 10,
                              color: _isWithinWorkingHours ? Colors.green : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Tracking berjalan pada jam kerja. Akan berhenti setelah absen pulang.',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Notifications
          SwitchListTile(
            title: const Text('Notifikasi'),
            subtitle: const Text('Terima notifikasi push'),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications, color: AppColors.primary, size: 20),
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

          // Background Tracking (Enterprise Feature)
          SwitchListTile(
            title: Row(
              children: [
                const Text('Tracking Background'),
                const SizedBox(width: 8),
                const EnterpriseBadge(),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Izinkan tracking lokasi di background'),
                const SizedBox(height: 4),
                Text(
                  '✅ Tetap berjalan meskipun aplikasi ditutup\n✅ Berjalan sesuai jam kerja\n✅ Restart otomatis saat HP dinyalakan ulang',
                  style: TextStyle(fontSize: 11, color: Colors.green.shade700),
                ),
              ],
            ),
            secondary: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.location_on, color: AppColors.primary, size: 20),
            ),
            value: _backgroundTrackingEnabled,
            onChanged: (value) {
              setState(() => _backgroundTrackingEnabled = value);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value ? 'Tracking background diaktifkan' : 'Tracking background dinonaktifkan')),
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
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.ads_click, color: AppColors.primary, size: 20),
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

          // QRIS Donation
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.qr_code, color: Colors.amber, size: 20),
            ),
            title: const Text('Donasi via QRIS'),
            subtitle: const Text('Dukung pengembangan aplikasi'),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => context.push('/qris'),
          ),

          const SizedBox(height: 24),

          // Info section
          Text(
            'Pengaturan ini akan disimpan di perangkat Anda',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Background tracking membutuhkan izin lokasi "Selalu"',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}