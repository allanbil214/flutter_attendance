import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../widgets/attendance_record_item.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';
import '../../../core/widgets/shared/enterprise_badge.dart';
import '../../../core/widgets/shared/tracking_status_indicator.dart';

class PresensiPage extends StatelessWidget {
  const PresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy active kegiatan
    final activeKegiatan = {
      'name': 'Piket Harian Guru',
      'location': 'SD Islam Alfitrah Binjai',
      'date': '2026-04-15',
      'checkinTime': '07:00',
      'checkoutTime': '15:00',
    };

    // Dummy attendance records
    final dummyRecords = [
      AttendanceRecord(
        date: '2026-04-14',
        checkin: '07:02',
        checkout: '15:05',
        status: 'Hadir',
      ),
      AttendanceRecord(
        date: '2026-04-13',
        checkin: '07:00',
        checkout: '15:00',
        status: 'Hadir',
      ),
      AttendanceRecord(
        date: '2026-04-12',
        checkin: '07:15',
        checkout: '15:00',
        status: 'Terlambat',
        lateMinutes: 15,
      ),
      AttendanceRecord(
        date: '2026-04-11',
        checkin: '07:00',
        checkout: '14:30',
        status: 'Pulang Awal',
        earlyMinutes: 30,
      ),
    ];

    // Check if user has checked in today (dummy - Phase 2 will be real)
    final hasCheckedIn = true; // For demo
    final hasCheckedOut = false; // For demo

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            // Header Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: FadeInSlide(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          activeKegiatan['name']!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, size: 12, color: Colors.white70),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                activeKegiatan['location']!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            activeKegiatan['date']!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Tracking Status Card (NEW)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FadeInSlide(
                  child: TrackingStatusIndicator(
                    hasCheckedIn: hasCheckedIn,
                    hasCheckedOut: hasCheckedOut,
                    checkinTime: activeKegiatan['checkinTime'],
                    checkoutTime: activeKegiatan['checkoutTime'],
                    showEnterpriseBadge: true,
                  ),
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            
            // Attendance Buttons
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FadeInSlide(
                  child: Row(
                    children: [
                      Expanded(
                        child: _AttendanceButton(
                          title: 'Masuk',
                          icon: Icons.login,
                          color: AppColors.success,
                          time: hasCheckedIn ? '07:02' : null,
                          isActive: !hasCheckedIn,
                          onTap: () {
                            context.push('/maps-presensi', extra: 'masuk');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _AttendanceButton(
                          title: 'Pulang',
                          icon: Icons.logout,
                          color: AppColors.warning,
                          time: hasCheckedOut ? '15:00' : null,
                          isActive: hasCheckedIn && !hasCheckedOut,
                          onTap: () {
                            context.push('/maps-presensi', extra: 'pulang');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Action Buttons Row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadeInSlide(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.push('/upload-aktivitas');
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Laporkan\nAktivitas'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.push('/maps-presensi', extra: 'view');
                          },
                          icon: const Icon(Icons.map),
                          label: const Text('Cek\nLokasi Saya'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // History Title
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: FadeInSlide(
                  child: Text(
                    'Riwayat Presensi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            
            // Attendance List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FadeInSlide(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: AttendanceRecordItem(record: dummyRecords[index]),
                    ),
                  );
                },
                childCount: dummyRecords.length,
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }
}

class _AttendanceButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String? time;
  final bool isActive;
  final VoidCallback onTap;

  const _AttendanceButton({
    required this.title,
    required this.icon,
    required this.color,
    this.time,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? color : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (isActive ? color : Colors.grey).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isActive ? color : Colors.grey,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? color : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time ?? '--:--',
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}