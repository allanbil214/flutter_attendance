import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../widgets/kegiatan_card.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';

class KegiatanListPage extends StatelessWidget {
  const KegiatanListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for Phase 1
    final dummyKegiatan = [
      Kegiatan(
        id: '1',
        name: 'Piket Harian Guru',
        location: 'SD Islam Alfitrah Binjai',
        startDate: '2026-01-01',
        endDate: '2026-12-31',
        checkinTime: '07:00',
        checkoutTime: '15:00',
      ),
      Kegiatan(
        id: '2',
        name: 'Rapat Bulanan',
        location: 'Ruang Rapat',
        startDate: '2026-01-01',
        endDate: '2026-12-31',
        checkinTime: '09:00',
        checkoutTime: '12:00',
      ),
      Kegiatan(
        id: '3',
        name: 'Kunjungan Lapangan',
        location: 'Area Bekasi Barat',
        startDate: '2026-01-01',
        endDate: '2026-06-30',
        checkinTime: '08:00',
        checkoutTime: '17:00',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kegiatan Saya'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh data
          await Future.delayed(const Duration(seconds: 1));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: dummyKegiatan.length,
            itemBuilder: (context, index) {
              return FadeInSlide(
                offset: const Offset(0, 20),
                child: KegiatanCard(
                  kegiatan: dummyKegiatan[index],
                  onTap: () {
                    // Set active kegiatan (Phase 2 will use Riverpod)
                    context.go('/presensi');
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showJoinDialog(context);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    final otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Join Kegiatan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter OTP code to join a kegiatan'),
            const SizedBox(height: 16),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                hintText: 'OTP Code',
                prefixIcon: Icon(Icons.qr_code),
              ),
              maxLength: 6,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Join request sent (Demo)')),
              );
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}

class Kegiatan {
  final String id;
  final String name;
  final String location;
  final String startDate;
  final String endDate;
  final String checkinTime;
  final String checkoutTime;

  Kegiatan({
    required this.id,
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.checkinTime,
    required this.checkoutTime,
  });
}