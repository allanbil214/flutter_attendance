import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';

class InputKegiatanScreen extends StatefulWidget {
  const InputKegiatanScreen({super.key});

  @override
  State<InputKegiatanScreen> createState() => _InputKegiatanScreenState();
}

class _InputKegiatanScreenState extends State<InputKegiatanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _radiusController = TextEditingController();
  
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _checkinTime;
  TimeOfDay? _checkoutTime;
  
  String _latitude = '-6.223470';
  String _longitude = '106.977640';
  bool _isLoading = false;

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _startDate = date);
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );
    if (date != null) {
      setState(() => _endDate = date);
    }
  }

  Future<void> _selectCheckinTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _checkinTime = time);
    }
  }

  Future<void> _selectCheckoutTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _checkoutTime = time);
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kegiatan berhasil ditambahkan!'),
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
        title: const Text('Tambah Kegiatan'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FadeInSlide(
                child: Text(
                  'Informasi Dasar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Nama Kegiatan
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kegiatan',
                  hintText: 'Contoh: Piket Harian Guru',
                  prefixIcon: Icon(Icons.assignment),
                ),
                validator: (v) => v?.isEmpty == true ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              
              // Tempat/Lokasi
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Tempat/Lokasi',
                  hintText: 'Contoh: SD Islam Alfitrah Binjai',
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (v) => v?.isEmpty == true ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              
              // Alamat
              TextFormField(
                controller: _addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Alamat Lengkap',
                  hintText: 'Alamat lengkap lokasi kegiatan',
                  prefixIcon: Icon(Icons.map),
                ),
              ),
              const SizedBox(height: 16),
              
              // Map Placeholder
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Maps integration in Phase 3')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.adminPrimary,
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
                      controller: TextEditingController(text: _latitude),
                      decoration: const InputDecoration(
                        labelText: 'Latitude',
                        prefixIcon: Icon(Icons.pin_drop),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: _longitude),
                      decoration: const InputDecoration(
                        labelText: 'Longitude',
                        prefixIcon: Icon(Icons.pin_drop),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Radius
              TextFormField(
                controller: _radiusController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Radius (meter)',
                  hintText: '100',
                  prefixIcon: Icon(Icons.radio_button_unchecked),
                  suffixText: 'm',
                ),
              ),
              const SizedBox(height: 24),
              
              const FadeInSlide(
                child: Text(
                  'Jadwal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Tanggal Mulai
              InkWell(
                onTap: _selectStartDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Mulai',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _startDate != null
                        ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                        : 'Pilih tanggal',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Tanggal Selesai
              InkWell(
                onTap: _selectEndDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Selesai',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Pilih tanggal',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Jam Masuk
              InkWell(
                onTap: _selectCheckinTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Jam Masuk',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    _checkinTime != null
                        ? _checkinTime!.format(context)
                        : 'Pilih jam',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Jam Pulang
              InkWell(
                onTap: _selectCheckoutTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Jam Pulang',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    _checkoutTime != null
                        ? _checkoutTime!.format(context)
                        : 'Pilih jam',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Save button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.adminPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Simpan Kegiatan'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}