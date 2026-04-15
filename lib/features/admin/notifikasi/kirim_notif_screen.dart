import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class KirimNotifScreen extends StatefulWidget {
  const KirimNotifScreen({super.key});

  @override
  State<KirimNotifScreen> createState() => _KirimNotifScreenState();
}

class _KirimNotifScreenState extends State<KirimNotifScreen> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _tokenController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendNotification() async {
    if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon isi judul dan pesan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSending = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isSending = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notifikasi terkirim! (Demo)'),
          backgroundColor: AppColors.success,
        ),
      );
      _titleController.clear();
      _messageController.clear();
      _tokenController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kirim Notifikasi'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Judul Notifikasi',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Masukkan judul notifikasi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Pesan',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Masukkan isi pesan',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Token (Opsional)',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                hintText: 'Kosongkan untuk kirim ke semua',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            // Target audience info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.adminSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people, color: AppColors.adminPrimary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Akan dikirim ke:',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Semua karyawan aktif',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendNotification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSending
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Kirim Notifikasi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}