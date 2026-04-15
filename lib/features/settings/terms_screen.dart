import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Syarat dan Ketentuan Penggunaan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            
            _Section(
              title: '1. Penerimaan Syarat',
              content: 'Dengan menggunakan aplikasi SmartPresensi, Anda menyetujui syarat dan ketentuan yang berlaku. Jika tidak setuju, jangan gunakan aplikasi ini.',
            ),
            
            _Section(
              title: '2. Perubahan Ketentuan',
              content: 'Kami berhak mengubah syarat dan ketentuan ini sewaktu-waktu. Perubahan akan diumumkan melalui aplikasi.',
            ),
            
            _Section(
              title: '3. Akun Pengguna',
              content: 'Anda bertanggung jawab penuh atas keamanan akun Anda. Jangan bagikan kredensial login Anda kepada siapapun.',
            ),
            
            _Section(
              title: '4. Privasi Data',
              content: 'Data lokasi dan aktivitas Anda dikumpulkan untuk keperluan presensi. Data tidak akan dijual kepada pihak ketiga.',
            ),
            
            _Section(
              title: '5. Penggunaan Lokasi',
              content: 'Aplikasi memerlukan akses lokasi untuk fungsi presensi. Lokasi akan direkam saat check-in/out dan saat tracking aktif.',
            ),
            
            _Section(
              title: '6. Pembatalan Akun',
              content: 'Admin organisasi dapat menonaktifkan akun karyawan. Akun personal dapat dihapus melalui pengaturan.',
            ),
            
            const SizedBox(height: 20),
            
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Saya Setuju'),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}