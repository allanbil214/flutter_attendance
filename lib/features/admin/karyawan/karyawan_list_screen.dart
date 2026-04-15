import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../widgets/admin_karyawan_card.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';
import '../../../core/widgets/shared/enterprise_badge.dart';

class KaryawanListScreen extends StatelessWidget {
  const KaryawanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kegiatan = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    // Dummy karyawan data with GPS status
    final List<Map<String, dynamic>> karyawanList = [
      {
        'id': '1',
        'name': 'Siti Aminah',
        'email': 'siti.aminah@gmail.com',
        'phone': '081299887766',
        'employeeId': 'EMP-A-002',
        'photoUrl': null,
        'gpsStatus': 'ON',
        'trackingStatus': 'active',
        'lastUpdate': '2 menit lalu',
      },
      {
        'id': '2',
        'name': 'Budi Santoso',
        'email': 'budi.santoso@gmail.com',
        'phone': '081355443322',
        'employeeId': 'EMP-A-003',
        'photoUrl': null,
        'gpsStatus': 'ON',
        'trackingStatus': 'active',
        'lastUpdate': '5 menit lalu',
      },
      {
        'id': '3',
        'name': 'Andi Firmansyah',
        'email': 'andi.firmansyah@gmail.com',
        'phone': '081122334455',
        'employeeId': 'EMP-A-001',
        'photoUrl': null,
        'gpsStatus': 'OFF',
        'trackingStatus': 'inactive',
        'lastUpdate': '1 jam lalu',
        'warning': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(kegiatan != null ? 'Daftar Karyawan - ${kegiatan['name']}' : 'Daftar Karyawan'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
        actions: [
          // GPS Filter Button
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              // Filter logic would go here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Filter: $value')),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'all', child: Text('Semua Karyawan')),
              const PopupMenuItem(value: 'gps_on', child: Text('GPS ON')),
              const PopupMenuItem(value: 'gps_off', child: Text('GPS OFF')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => context.push('/admin-input-karyawan'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(const Duration(seconds: 1)),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: karyawanList.length,
          itemBuilder: (context, index) {
            final karyawan = karyawanList[index];
            return FadeInSlide(
              offset: const Offset(0, 20),
              child: AdminKaryawanCard(
                karyawan: karyawan,
                onEdit: () {
                  context.push('/admin-edit-karyawan', extra: karyawan);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/admin-input-karyawan'),
        backgroundColor: AppColors.adminPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }
}