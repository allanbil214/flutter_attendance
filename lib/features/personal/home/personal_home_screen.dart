import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../widgets/aktivitas_card.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';
import '../../../data/datasources/local/shared_prefs_helper.dart';
import '../../../data/datasources/remote/api_client.dart';

class PersonalHomeScreen extends StatefulWidget {
  const PersonalHomeScreen({super.key});

  @override
  State<PersonalHomeScreen> createState() => _PersonalHomeScreenState();
}

class _PersonalHomeScreenState extends State<PersonalHomeScreen> {
  DateTime? _selectedDate;
  bool _isLoading = false;
  
  // Dummy activities data
  final List<Map<String, dynamic>> _allActivities = [
    {
      'id': '1',
      'title': 'Survey Lokasi Baru',
      'description': 'Melakukan survey untuk calon lokasi cabang baru di area Bekasi Barat. Lokasi strategis dekat dengan pusat perbelanjaan.',
      'location': 'Bekasi Barat, Jawa Barat',
      'date': '2026-04-14',
      'latitude': '-6.223470',
      'longitude': '106.977640',
      'photos': ['photo1.jpg', 'photo2.jpg'],
    },
    {
      'id': '2',
      'title': 'Meeting dengan Klien',
      'description': 'Presentasi proposal proyek dan negosiasi kontrak. Klien sangat tertarik dengan solusi yang ditawarkan.',
      'location': 'Grand Indonesia, Jakarta',
      'date': '2026-04-13',
      'latitude': '-6.195200',
      'longitude': '106.822900',
      'photos': ['photo3.jpg'],
    },
    {
      'id': '3',
      'title': 'Inspeksi Gudang',
      'description': 'Pengecekan stok barang dan kondisi gudang. Semua dalam kondisi baik dan tertata rapi.',
      'location': 'Kawasan Industri Pulogadung, Jakarta Timur',
      'date': '2026-04-12',
      'latitude': '-6.208800',
      'longitude': '106.919100',
      'photos': ['photo4.jpg', 'photo5.jpg', 'photo6.jpg'],
    },
    {
      'id': '4',
      'title': 'Pelatihan Tim',
      'description': 'Pelatihan penggunaan aplikasi baru untuk tim sales. Semua peserta antusias dan aktif bertanya.',
      'location': 'Meeting Room, Kantor Pusat',
      'date': '2026-04-10',
      'latitude': '-6.200000',
      'longitude': '106.850000',
      'photos': ['photo7.jpg'],
    },
  ];

  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedDate == null) {
      return _allActivities;
    }
    final dateStr = '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';
    return _allActivities.where((a) => a['date'] == dateStr).toList();
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  Future<void> _logout() async {
    // Call logout API
    final apiClient = ApiClient();
    await apiClient.logout();
    
    // Clear personal session
    await SharedPrefsHelper.clearPersonalSession();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda telah logout'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/login-method');
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredActivities = _filteredActivities;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivitas Saya'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.personalGradient,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/personal-settings');
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],

      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            // Profile header
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.personalGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: AppColors.personalPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal User',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'user@gmail.com',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: _showLogoutDialog,
                    ),
                  ],
                ),
              ),
            ),
            
            // Date filter
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'Filter Tanggal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _selectedDate = date;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDate != null
                                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                    : 'Semua Tanggal',
                                style: TextStyle(
                                  color: _selectedDate != null
                                      ? AppColors.textPrimary
                                      : Colors.grey.shade500,
                                ),
                              ),
                              if (_selectedDate != null)
                                IconButton(
                                  icon: const Icon(Icons.close, size: 16),
                                  onPressed: () {
                                    setState(() {
                                      _selectedDate = null;
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            
            // Activity count
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '${filteredActivities.length} aktivitas ditemukan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            
            // Activities list
            filteredActivities.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_turned_in,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada aktivitas',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.push('/personal-upload');
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Buat Aktivitas Baru'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.personalPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FadeInSlide(
                          offset: const Offset(0, 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: AktivitasCard(
                              aktivitas: filteredActivities[index],
                              onTap: () {
                                context.push('/personal-galeri', extra: filteredActivities[index]);
                              },
                              onDelete: () {
                                _showDeleteDialog(filteredActivities[index]);
                              },
                            ),
                          ),
                        );
                      },
                      childCount: filteredActivities.length,
                    ),
                  ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/personal-upload');
        },
        backgroundColor: AppColors.personalPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(Map<String, dynamic> aktivitas) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Aktivitas'),
        content: Text('Apakah Anda yakin ingin menghapus "${aktivitas['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Aktivitas dihapus (Demo)'),
                  backgroundColor: Colors.red,
                ),
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
}