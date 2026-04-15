import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';

class KegiatanCard extends StatelessWidget {
  final dynamic kegiatan;
  final VoidCallback onTap;

  const KegiatanCard({
    super.key,
    required this.kegiatan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                color: AppColors.primary,
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
                      kegiatan.name,
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
                            kegiatan.location,
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
                    const SizedBox(height: 8),
                    // Date range
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 10, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          '${kegiatan.startDate} - ${kegiatan.endDate}',
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
                          '${kegiatan.checkinTime} - ${kegiatan.checkoutTime}',
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Tap hint
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primarySoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Tap to start',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}