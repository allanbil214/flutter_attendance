import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';

class AdminKaryawanCard extends StatelessWidget {
  final Map<String, dynamic> karyawan;
  final VoidCallback onEdit;

  const AdminKaryawanCard({
    super.key,
    required this.karyawan,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.adminSoft,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 40,
                color: AppColors.adminPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Name
          Text(
            karyawan['name'],
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            karyawan['email'],
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Edit button
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.adminSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 14, color: AppColors.adminPrimary),
                  const SizedBox(width: 4),
                  Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.adminPrimary,
                      fontWeight: FontWeight.w500,
                    ),
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