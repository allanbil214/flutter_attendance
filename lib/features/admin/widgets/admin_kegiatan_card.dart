import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';

class AdminKegiatanCard extends StatelessWidget {
  final Map<String, dynamic> kegiatan;
  final VoidCallback onDaftarKaryawan;
  final VoidCallback onCekLaporan;
  final VoidCallback onTracking;
  final VoidCallback onMenu;

  const AdminKegiatanCard({
    super.key,
    required this.kegiatan,
    required this.onDaftarKaryawan,
    required this.onCekLaporan,
    required this.onTracking,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top colored bar
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.adminPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity name
                  Text(
                    kegiatan['name'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kegiatan['location'],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Date range
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 10, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        '${kegiatan['startDate']} - ${kegiatan['endDate']}',
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Time
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                          size: 10, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        '${kegiatan['checkinTime']} - ${kegiatan['checkoutTime']}',
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ActionButton(
                        icon: Icons.people,
                        label: 'Daftar',
                        onTap: onDaftarKaryawan,
                      ),
                      _ActionButton(
                        icon: Icons.assessment,
                        label: 'Laporan',
                        onTap: onCekLaporan,
                      ),
                      _ActionButton(
                        icon: Icons.location_on,
                        label: 'Tracking',
                        onTap: onTracking,
                      ),
                      _ActionButton(
                        icon: Icons.more_horiz,
                        label: 'Menu',
                        onTap: onMenu,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.adminSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: AppColors.adminPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}