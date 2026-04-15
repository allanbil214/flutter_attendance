import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            // Logo
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // App name
            Text(
              AppConstants.appName,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Version
            Text(
              'Version ${AppConstants.appVersion}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'SmartPresensi adalah aplikasi presensi berbasis GPS untuk memantau kehadiran dan aktivitas karyawan secara real-time.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _FeatureItem(
                    icon: Icons.fingerprint,
                    title: 'Presensi GPS',
                    description: 'Check-in/out dengan verifikasi lokasi',
                  ),
                  const SizedBox(height: 16),
                  _FeatureItem(
                    icon: Icons.location_on,
                    title: 'Tracking Real-time',
                    description: 'Pantau lokasi karyawan secara langsung',
                  ),
                  const SizedBox(height: 16),
                  _FeatureItem(
                    icon: Icons.assignment,
                    title: 'Laporan Aktivitas',
                    description: 'Dokumentasi kegiatan dengan foto',
                  ),
                  const SizedBox(height: 16),
                  _FeatureItem(
                    icon: Icons.notifications,
                    title: 'Notifikasi Push',
                    description: 'Informasi penting langsung ke HP',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Contact
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.email, color: AppColors.primary),
                    title: const Text('support@smartpresensi.com'),
                    onTap: () {
                      // TODO: Launch email
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone, color: AppColors.primary),
                    title: const Text('+62 812 3456 7890'),
                    onTap: () {
                      // TODO: Launch phone
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.web, color: AppColors.primary),
                    title: const Text('www.smartpresensi.com'),
                    onTap: () {
                      // TODO: Launch website
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}