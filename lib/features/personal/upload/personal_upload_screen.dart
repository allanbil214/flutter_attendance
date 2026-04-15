import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';

class PersonalUploadScreen extends StatefulWidget {
  const PersonalUploadScreen({super.key});

  @override
  State<PersonalUploadScreen> createState() => _PersonalUploadScreenState();
}

class _PersonalUploadScreenState extends State<PersonalUploadScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  
  DateTimeRange? _dateRange;
  String _latitude = '-6.223470';
  String _longitude = '106.977640';
  bool _isLoading = false;

  Future<void> _selectDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      initialDateRange: _dateRange,
    );
    if (range != null) {
      setState(() {
        _dateRange = range;
      });
    }
  }

  Future<void> _selectLocation() async {
    // For Phase 1, just show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Maps integration will be available in Phase 3')),
    );
  }

  Future<void> _handleSave() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon isi judul dan deskripsi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aktivitas berhasil disimpan!'),
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
        title: const Text('Tambah Aktivitas'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.personalGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FadeInSlide(
              child: Text(
                'Informasi Aktivitas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Aktivitas',
                hintText: 'Contoh: Survey Lokasi Baru',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),
            
            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Ceritakan detail aktivitas Anda...',
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            
            // Date Range
            InkWell(
              onTap: _selectDateRange,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Rentang Tanggal',
                  prefixIcon: Icon(Icons.date_range),
                ),
                child: Text(
                  _dateRange != null
                      ? '${_dateRange!.start.day}/${_dateRange!.start.month}/${_dateRange!.start.year} - ${_dateRange!.end.day}/${_dateRange!.end.month}/${_dateRange!.end.year}'
                      : 'Pilih rentang tanggal',
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            const FadeInSlide(
              child: Text(
                'Lokasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Location search
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Nama Lokasi',
                hintText: 'Contoh: Grand Indonesia, Jakarta',
                prefixIcon: Icon(Icons.location_on),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            
            // Map placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 8),
                  Text(
                    'Pilih Lokasi di Maps',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lat: $_latitude, Lng: $_longitude',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _selectLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.personalPrimary,
                    ),
                    child: const Text('Pilih Lokasi'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Lat/Long
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _latitude,
                    decoration: const InputDecoration(
                      labelText: 'Latitude',
                      prefixIcon: Icon(Icons.pin_drop),
                    ),
                    onChanged: (value) => _latitude = value,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: _longitude,
                    decoration: const InputDecoration(
                      labelText: 'Longitude',
                      prefixIcon: Icon(Icons.pin_drop),
                    ),
                    onChanged: (value) => _longitude = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Save button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.personalPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan Aktivitas'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}