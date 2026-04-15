import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';

class EditKegiatanScreen extends StatefulWidget {
  const EditKegiatanScreen({super.key});

  @override
  State<EditKegiatanScreen> createState() => _EditKegiatanScreenState();
}

class _EditKegiatanScreenState extends State<EditKegiatanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _radiusController = TextEditingController(text: '100');
  
  DateTime? _startDate = DateTime(2026, 1, 1);
  DateTime? _endDate = DateTime(2026, 12, 31);
  TimeOfDay? _checkinTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay? _checkoutTime = const TimeOfDay(hour: 15, minute: 0);
  
  String _latitude = '-6.223470';
  String _longitude = '106.977640';
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final kegiatan = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (kegiatan != null) {
      _nameController.text = kegiatan['name'] ?? '';
      _locationController.text = kegiatan['location'] ?? '';
    }
  }

  Future<void> _handleSave() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kegiatan berhasil diupdate!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kegiatan'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const FadeInSlide(
                child: Text(
                  'Edit Informasi Kegiatan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kegiatan',
                  prefixIcon: Icon(Icons.assignment),
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Tempat/Lokasi',
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              const SizedBox(height: 16),
              
              // Ubah Lokasi button
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ubah Lokasi - Maps integration in Phase 3')),
                  );
                },
                icon: const Icon(Icons.edit_location),
                label: const Text('Ubah Lokasi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminPrimary,
                ),
              ),
              const SizedBox(height: 16),
              
              // Rest of form similar to input_kegiatan_screen...
              const SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.adminPrimary,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Update Kegiatan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}