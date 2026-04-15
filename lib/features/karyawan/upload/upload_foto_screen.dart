import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class UploadFotoScreen extends StatefulWidget {
  const UploadFotoScreen({super.key});

  @override
  State<UploadFotoScreen> createState() => _UploadFotoScreenState();
}

class _UploadFotoScreenState extends State<UploadFotoScreen> {
  bool _hasPhoto = false;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Foto'),
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
            // Photo Preview
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _hasPhoto
                    ? const Center(
                        child: Icon(
                          Icons.check_circle,
                          size: 80,
                          color: AppColors.success,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate,
                              size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada foto',
                            style: TextStyle(color: Colors.grey.shade500),
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
                              _hasPhoto = !_hasPhoto;
                            });
                          },
                    icon: Icon(_hasPhoto ? Icons.refresh : Icons.camera_alt),
                    label: Text(_hasPhoto ? 'Ambil Ulang' : 'Ambil Foto'),
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
                    onPressed: _hasPhoto && !_isUploading
                        ? () async {
                            setState(() => _isUploading = true);
                            await Future.delayed(const Duration(seconds: 1));
                            setState(() => _isUploading = false);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Foto berhasil diupload!'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                              Navigator.pop(context);
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
                        : const Icon(Icons.upload),
                    label: Text(_isUploading ? 'Mengupload...' : 'Upload'),
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