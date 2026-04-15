import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';

class SwafotoScreen extends StatefulWidget {
  const SwafotoScreen({super.key});

  @override
  State<SwafotoScreen> createState() => _SwafotoScreenState();
}

class _SwafotoScreenState extends State<SwafotoScreen> {
  bool _isPhotoTaken = false;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final mode = ModalRoute.of(context)?.settings.arguments as String? ?? 'masuk';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(mode == 'masuk' ? 'Foto Check In' : 'Foto Check Out'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Camera Preview Placeholder
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _isPhotoTaken
                    ? Center(
                        child: Icon(
                          Icons.check_circle,
                          size: 80,
                          color: AppColors.success,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera, size: 64, color: Colors.grey.shade600),
                          const SizedBox(height: 16),
                          Text(
                            'Camera preview will appear here',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Camera integration in Phase 3',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isUploading
                        ? null
                        : () {
                            setState(() {
                              _isPhotoTaken = !_isPhotoTaken;
                            });
                          },
                    icon: Icon(_isPhotoTaken ? Icons.refresh : Icons.camera_alt),
                    label: Text(_isPhotoTaken ? 'Ambil Ulang' : 'Swa Foto'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isPhotoTaken && !_isUploading
                        ? () async {
                            setState(() => _isUploading = true);
                            await Future.delayed(const Duration(seconds: 1));
                            setState(() => _isUploading = false);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Presensi berhasil!'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                              context.go('/presensi');
                            }
                          }
                        : null,
                    icon: _isUploading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check),
                    label: Text(_isUploading ? 'Mengirim...' : 'Selanjutnya'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
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
    );
  }
}