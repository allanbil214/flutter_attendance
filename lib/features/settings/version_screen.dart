import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/app_constants.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy latest version data
    final latestVersion = '1.2.0';
    final isUpdateAvailable = latestVersion != AppConstants.appVersion;
    final forceUpdate = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Versi Aplikasi'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.update,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              
              Text(
                'Versi Saat Ini',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                AppConstants.appVersion,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Container(
                height: 1,
                width: 100,
                color: Colors.grey.shade300,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Versi Terbaru',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                latestVersion,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isUpdateAvailable ? AppColors.warning : AppColors.success,
                ),
              ),
              
              const SizedBox(height: 32),
              
              if (isUpdateAvailable)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.warning),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              forceUpdate 
                                  ? 'Update wajib untuk melanjutkan penggunaan aplikasi'
                                  : 'Update tersedia. Disarankan untuk update',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Membuka Play Store... (Phase 2)')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Update Sekarang'),
                      ),
                    ),
                  ],
                )
              else
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.success),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Aplikasi Anda sudah menggunakan versi terbaru'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}