import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../widgets/admin_kegiatan_card.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';
import '../../../core/services/logout_service.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  int _notificationCount = 3;
  bool _showNotifications = false;
  bool _isFabOpen = false;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabRotation;
  late Animation<double> _fabScale;
  
  // Dummy notifications
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Check-in Baru',
      'message': 'Siti Aminah check-in pukul 07:02',
      'time': '2 menit lalu',
      'type': 'checkin',
      'read': false,
    },
    {
      'id': '2',
      'title': 'Check-in Baru',
      'message': 'Budi Santoso check-in pukul 06:55',
      'time': '15 menit lalu',
      'type': 'checkin',
      'read': false,
    },
    {
      'id': '3',
      'title': 'GPS Mati',
      'message': 'Andi Firmansyah GPS mati - tidak terdeteksi',
      'time': '1 jam lalu',
      'type': 'warning',
      'read': false,
    },
    {
      'id': '4',
      'title': 'Check-out',
      'message': 'Riska Dewi check-out pukul 17:05',
      'time': '2 jam lalu',
      'type': 'checkout',
      'read': true,
    },
  ];

  // Dummy kegiatan data
  final List<Map<String, dynamic>> _kegiatanList = [
    {
      'id': '1',
      'name': 'Piket Harian Guru',
      'location': 'SD Islam Alfitrah Binjai',
      'startDate': '2026-01-01',
      'endDate': '2026-12-31',
      'checkinTime': '07:00',
      'checkoutTime': '15:00',
      'status': 'active',
    },
    {
      'id': '2',
      'name': 'Rapat Bulanan',
      'location': 'Ruang Rapat',
      'startDate': '2026-01-01',
      'endDate': '2026-12-31',
      'checkinTime': '09:00',
      'checkoutTime': '12:00',
      'status': 'active',
    },
    {
      'id': '3',
      'name': 'Kunjungan Lapangan',
      'location': 'Area Bekasi Barat',
      'startDate': '2026-01-01',
      'endDate': '2026-06-30',
      'checkinTime': '08:00',
      'checkoutTime': '17:00',
      'status': 'active',
    },
  ];

  // Today's stats
  final Map<String, dynamic> _todayStats = {
    'totalEmployees': 5,
    'checkedIn': 3,
    'checkedOut': 1,
    'onTime': 2,
    'late': 1,
    'gpsOff': 1,
  };

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fabRotation = Tween<double>(begin: 0.0, end: 0.625).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );
    _fabScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabOpen = !_isFabOpen;
      if (_isFabOpen) {
        _fabAnimationController.forward();
      } else {
        _fabAnimationController.reverse();
      }
    });
  }

  void _closeFab() {
    if (_isFabOpen) {
      setState(() {
        _isFabOpen = false;
        _fabAnimationController.reverse();
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _markNotificationAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n['id'] == id);
      if (index != -1) {
        _notifications[index]['read'] = true;
      }
      _notificationCount = _notifications.where((n) => !n['read']).length;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) {
        n['read'] = true;
      }
      _notificationCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
        actions: [
          // Notification Bell with Badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  setState(() {
                    _showNotifications = !_showNotifications;
                  });
                },
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refreshData,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        // Today's Stats Card
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: AppColors.adminGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Hari Ini',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.spaceAround,
                                children: [
                                  _StatCircle(
                                    label: 'Hadir',
                                    value: '${_todayStats['checkedIn']}',
                                    icon: Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  _StatCircle(
                                    label: 'Tepat Waktu',
                                    value: '${_todayStats['onTime']}',
                                    icon: Icons.access_time,
                                    color: Colors.blue,
                                  ),
                                  _StatCircle(
                                    label: 'Terlambat',
                                    value: '${_todayStats['late']}',
                                    icon: Icons.warning,
                                    color: Colors.orange,
                                  ),
                                  _StatCircle(
                                    label: 'GPS OFF',
                                    value: '${_todayStats['gpsOff']}',
                                    icon: Icons.gps_off,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Warning Banner for GPS Issues
                        if (_todayStats['gpsOff'] > 0)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red.shade300),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.warning, color: Colors.red),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Perhatian!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        '${_todayStats['gpsOff']} karyawan dengan GPS mati. Tracking tidak berjalan.',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.push('/admin-tracking');
                                  },
                                  child: const Text('Lihat'),
                                ),
                              ],
                            ),
                          ),
                        
                        const SizedBox(height: 16),
                        
                        // Kegiatan Grid
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: _kegiatanList.length,
                            itemBuilder: (context, index) {
                              return FadeInSlide(
                                offset: const Offset(0, 20),
                                child: AdminKegiatanCard(
                                  kegiatan: _kegiatanList[index],
                                  onDaftarKaryawan: () {
                                    context.push('/admin-karyawan-list', extra: _kegiatanList[index]);
                                  },
                                  onCekLaporan: () {
                                    context.push('/admin-laporan', extra: _kegiatanList[index]);
                                  },
                                  onTracking: () {
                                    context.push('/admin-tracking', extra: _kegiatanList[index]);
                                  },
                                  onMenu: () {
                                    _showKegiatanMenu(_kegiatanList[index]);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
          ),
          
          // Backdrop to close FAB when tapping outside
          if (_isFabOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeFab,
                child: AnimatedOpacity(
                  opacity: _isFabOpen ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),

          // Notifications Dropdown
          if (_showNotifications)
            Positioned(
              top: 60,
              right: 10,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 320,
                  constraints: const BoxConstraints(maxHeight: 400),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Notifikasi',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: _markAllAsRead,
                              child: const Text('Baca Semua'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      
                      // Notifications List
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _notifications.length,
                          itemBuilder: (context, index) {
                            final notif = _notifications[index];
                            return _NotificationItem(
                              notification: notif,
                              onTap: () {
                                _markNotificationAsRead(notif['id']);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      
      floatingActionButton: _buildSpeedDial(),
    );
  }

  Widget _buildSpeedDial() {
    final List<Map<String, dynamic>> fabItems = [
      {
        'icon': Icons.person_add,
        'label': 'Karyawan',
        'color': AppColors.adminPrimary,
        'onTap': () { _closeFab(); context.push('/admin-input-karyawan'); },
      },
      {
        'icon': Icons.business,
        'label': 'Organisasi',
        'color': AppColors.adminPrimary,
        'onTap': () { _closeFab(); context.push('/admin-organisasi'); },
      },
      {
        'icon': Icons.notifications,
        'label': 'Notifikasi',
        'color': AppColors.adminPrimary,
        'onTap': () { _closeFab(); context.push('/admin-kirim-notif'); },
      },
      {
        'icon': Icons.settings,
        'label': 'Settings',
        'color': AppColors.adminPrimary,
        'onTap': () { _closeFab(); context.push('/admin-settings'); },
      },
      {
        'icon': Icons.logout,
        'label': 'Logout',
        'color': Colors.red,
        'onTap': () { _closeFab(); LogoutService.showLogoutDialog(context); }, // ← changed
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...fabItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final staggeredBegin = (fabItems.length - 1 - index) * 0.12;
          final staggerEnd = (staggeredBegin + 0.5).clamp(0.0, 1.0);
          final itemAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _fabAnimationController,
              curve: Interval(staggeredBegin, staggerEnd, curve: Curves.easeOut),
            ),
          );
          return AnimatedBuilder(
            animation: itemAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - itemAnimation.value)),
                child: Opacity(
                  opacity: itemAnimation.value.clamp(0.0, 1.0),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildSpeedDialItem(
                icon: item['icon'] as IconData,
                label: item['label'] as String,
                color: item['color'] as Color,
                onTap: item['onTap'] as VoidCallback,
              ),
            ),
          );
        }).toList(),

        // Main FAB with rotating icon
        AnimatedBuilder(
          animation: _fabRotation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _fabRotation.value * 2 * 3.14159,
              child: child,
            );
          },
          child: FloatingActionButton(
            onPressed: _toggleFab,
            backgroundColor: _isFabOpen ? Colors.grey.shade700 : AppColors.adminPrimary,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isFabOpen ? Icons.close : Icons.menu,
                key: ValueKey(_isFabOpen),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedDialItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  void _showKegiatanMenu(Map<String, dynamic> kegiatan) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              kegiatan['name'],
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.adminPrimary),
              title: const Text('Edit Kegiatan'),
              onTap: () {
                Navigator.pop(context);
                context.push('/admin-edit-kegiatan', extra: kegiatan);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Hapus Kegiatan'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmDialog(kegiatan);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmDialog(Map<String, dynamic> kegiatan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Kegiatan'),
        content: Text('Apakah Anda yakin ingin menghapus "${kegiatan['name']}"?'),
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
                  content: Text('Kegiatan dihapus (Demo)'),
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

class _StatCircle extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCircle({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    IconData iconData;
    
    switch (notification['type']) {
      case 'checkin':
        iconColor = Colors.green;
        iconData = Icons.login;
        break;
      case 'checkout':
        iconColor = Colors.orange;
        iconData = Icons.logout;
        break;
      case 'warning':
        iconColor = Colors.red;
        iconData = Icons.warning;
        break;
      default:
        iconColor = Colors.blue;
        iconData = Icons.notifications;
    }
    
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: notification['read'] ? Colors.white : AppColors.adminSoft,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    notification['message'],
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    notification['time'],
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification['read'])
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}