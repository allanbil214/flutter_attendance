import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';

class MapsPresensiScreen extends StatelessWidget {
  const MapsPresensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = ModalRoute.of(context)?.settings.arguments as String? ?? 'masuk';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(mode == 'masuk' ? 'Check In' : mode == 'pulang' ? 'Check Out' : 'Lokasi Saya'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: Column(
        children: [
          // Map Placeholder
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 8),
                  Text(
                    'Google Maps will be integrated in Phase 3',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ),
          
          // Address Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.primary),
                      const SizedBox(width: 8),
                      const Text(
                        'Lokasi Anda',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Jl. Sudirman No.12, Binjai, Sumatera Utara',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Navigate to selfie
                            context.push('/swafoto', extra: mode);
                          },
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Swa Foto'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
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
                            // Refresh location
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Mengambil lokasi...')),
                            );
                          },
                          icon: const Icon(Icons.my_location),
                          label: const Text('Lokasi Saya'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
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