import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';

class GaleriAktivitasScreen extends StatefulWidget {
  const GaleriAktivitasScreen({super.key});

  @override
  State<GaleriAktivitasScreen> createState() => _GaleriAktivitasScreenState();
}

class _GaleriAktivitasScreenState extends State<GaleriAktivitasScreen> {
  late Map<String, dynamic> _aktivitas;
  List<String> _photos = [];
  bool _isEditing = false;
  late TextEditingController _descriptionController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _aktivitas = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    _photos = List<String>.from(_aktivitas['photos'] ?? []);
    _descriptionController = TextEditingController(text: _aktivitas['description']);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addPhoto() async {
    // For Phase 1, just add dummy photo
    setState(() {
      _photos.add('dummy_photo_${_photos.length + 1}');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Foto ditambahkan (Demo - Camera in Phase 3)')),
    );
  }

  void _deletePhoto(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Foto'),
        content: const Text('Apakah Anda yakin ingin menghapus foto ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _photos.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Foto dihapus')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _saveDescription() async {
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deskripsi berhasil diupdate!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_aktivitas['title'] ?? 'Galeri Aktivitas'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.personalGradient,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveDescription();
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description section
            Container(
              padding: const EdgeInsets.all(16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_isEditing)
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Edit deskripsi aktivitas...',
                        border: OutlineInputBorder(),
                      ),
                    )
                  else
                    Text(
                      _descriptionController.text,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Location info
            Container(
              padding: const EdgeInsets.all(16),
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
              child: Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.personalPrimary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lokasi',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _aktivitas['location'] ?? 'Lokasi tidak tersedia',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Date info
            Container(
              padding: const EdgeInsets.all(16),
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
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: AppColors.personalPrimary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _aktivitas['date'] ?? 'Tanggal tidak tersedia',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Photos section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Foto Dokumentasi (${_photos.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _addPhoto,
                  icon: const Icon(Icons.add_a_photo, size: 18),
                  label: const Text('Tambah Foto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.personalPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Photo grid
            if (_photos.isEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_library, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Belum ada foto'),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: _photos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showPhotoPreview(index);
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(Icons.image, size: 32, color: Colors.grey),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _deletePhoto(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            
            const SizedBox(height: 80),
          ],
        ),
      ),
      // AdMob banner placeholder
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.grey.shade100,
        child: const Center(
          child: Text(
            'AdMob Banner (Phase 6)',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _showPhotoPreview(int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 64, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Tutup'),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _deletePhoto(index);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: const Text('Hapus', style: TextStyle(color: Colors.red)),
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