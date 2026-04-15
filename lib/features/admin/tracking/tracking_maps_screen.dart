import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/shared/enterprise_badge.dart';

class TrackingMapsScreen extends StatefulWidget {
  const TrackingMapsScreen({super.key});

  @override
  State<TrackingMapsScreen> createState() => _TrackingMapsScreenState();
}

class _TrackingMapsScreenState extends State<TrackingMapsScreen> {
  String _searchQuery = '';
  String _speedFilter = 'Semua';
  String _gpsFilter = 'Semua'; // Semua, ON, OFF
  
  // Dummy employee locations with enhanced tracking data
  final List<Map<String, dynamic>> _allEmployeeLocations = [
    {
      'id': '1',
      'name': 'Siti Aminah',
      'email': 'siti.aminah@gmail.com',
      'address': 'Jl. Sudirman No.12, Binjai',
      'latitude': '3.595600',
      'longitude': '98.673300',
      'speedKmh': 0.0,
      'speedCategory': 'Diam',
      'accuracyM': 5.0,
      'gpsStatus': 'ON',
      'trackingStatus': 'active',
      'lastUpdate': '2 menit lalu',
      'lastUpdateTime': DateTime.now().subtract(const Duration(minutes: 2)),
      'photoUrl': null,
      'status': 'active',
      'batteryLevel': 85,
      'checkedIn': true,
      'checkedInTime': '07:02',
      'workingHours': '08:00 - 16:00',
    },
    {
      'id': '2',
      'name': 'Budi Santoso',
      'email': 'budi.santoso@gmail.com',
      'address': 'Jl. Diponegoro No.45, Binjai',
      'latitude': '3.598200',
      'longitude': '98.675100',
      'speedKmh': 12.5,
      'speedCategory': 'Jalan',
      'accuracyM': 8.0,
      'gpsStatus': 'ON',
      'trackingStatus': 'active',
      'lastUpdate': '5 menit lalu',
      'lastUpdateTime': DateTime.now().subtract(const Duration(minutes: 5)),
      'photoUrl': null,
      'status': 'active',
      'batteryLevel': 67,
      'checkedIn': true,
      'checkedInTime': '06:55',
      'workingHours': '08:00 - 16:00',
    },
    {
      'id': '3',
      'name': 'Andi Firmansyah',
      'email': 'andi.firmansyah@gmail.com',
      'address': 'Jl. Veteran No.78, Binjai',
      'latitude': '3.591200',
      'longitude': '98.670100',
      'speedKmh': 0.0,
      'speedCategory': 'Diam',
      'accuracyM': 0.0,
      'gpsStatus': 'OFF',
      'trackingStatus': 'inactive',
      'lastUpdate': '1 jam lalu',
      'lastUpdateTime': DateTime.now().subtract(const Duration(hours: 1)),
      'photoUrl': null,
      'status': 'active',
      'batteryLevel': 23,
      'checkedIn': true,
      'checkedInTime': '07:15',
      'workingHours': '08:00 - 16:00',
      'gpsOffWarning': true,
    },
    {
      'id': '4',
      'name': 'Riska Dewi',
      'email': 'riska.dewi@gmail.com',
      'address': 'Jl. Merdeka No.23, Bekasi',
      'latitude': '-6.223470',
      'longitude': '106.977640',
      'speedKmh': 0.0,
      'speedCategory': 'Diam',
      'accuracyM': 0.0,
      'gpsStatus': 'OFF',
      'trackingStatus': 'inactive',
      'lastUpdate': '2 jam lalu',
      'lastUpdateTime': DateTime.now().subtract(const Duration(hours: 2)),
      'photoUrl': null,
      'status': 'inactive',
      'batteryLevel': 0,
      'checkedIn': false,
      'checkedInTime': null,
      'workingHours': '08:00 - 16:00',
      'gpsOffWarning': true,
    },
    {
      'id': '5',
      'name': 'Eko Wahyuning',
      'email': 'eko.wahyuning@gmail.com',
      'address': 'Jl. Raya Bekasi Km.20, Bekasi',
      'latitude': '-6.225000',
      'longitude': '106.980000',
      'speedKmh': 28.3,
      'speedCategory': 'Cepat',
      'accuracyM': 7.5,
      'gpsStatus': 'ON',
      'trackingStatus': 'active',
      'lastUpdate': '3 menit lalu',
      'lastUpdateTime': DateTime.now().subtract(const Duration(minutes: 3)),
      'photoUrl': null,
      'status': 'active',
      'batteryLevel': 91,
      'checkedIn': true,
      'checkedInTime': '07:00',
      'workingHours': '08:00 - 16:00',
    },
  ];

  List<Map<String, dynamic>> get _filteredEmployees {
    var filtered = _allEmployeeLocations.where((e) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        return e['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               e['email'].toLowerCase().contains(_searchQuery.toLowerCase());
      }
      return true;
    }).toList();
    
    // Speed filter
    if (_speedFilter != 'Semua') {
      filtered = filtered.where((e) => e['speedCategory'] == _speedFilter).toList();
    }
    
    // GPS filter
    if (_gpsFilter != 'Semua') {
      filtered = filtered.where((e) => e['gpsStatus'] == _gpsFilter).toList();
    }
    
    // Sort by last update (most recent first)
    filtered.sort((a, b) => b['lastUpdateTime'].compareTo(a['lastUpdateTime']));
    
    return filtered;
  }

  String _getSpeedIcon(double speed) {
    if (speed == 0) return '🚶';
    if (speed < 10) return '🚶‍♂️';
    if (speed < 25) return '🛵';
    return '🚗';
  }

  Color _getSpeedColor(double speed) {
    if (speed == 0) return Colors.grey;
    if (speed < 10) return AppColors.success;
    if (speed < 25) return AppColors.warning;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final kegiatan = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final filteredEmployees = _filteredEmployees;
    
    // Statistics
    final totalActive = _allEmployeeLocations.where((e) => e['status'] == 'active').length;
    final totalMoving = _allEmployeeLocations.where((e) => e['speedKmh'] > 0).length;
    final totalGpsOff = _allEmployeeLocations.where((e) => e['gpsStatus'] == 'OFF' && e['checkedIn'] == true).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(kegiatan != null ? 'Tracking - ${kegiatan['name']}' : 'Tracking Karyawan'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Memperbarui data...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Bar with GPS Warning
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppColors.adminGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      icon: Icons.people,
                      label: 'Aktif',
                      value: '$totalActive',
                      color: Colors.white,
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    _StatItem(
                      icon: Icons.directions_walk,
                      label: 'Bergerak',
                      value: '$totalMoving',
                      color: Colors.white,
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    _StatItem(
                      icon: Icons.speed,
                      label: 'Rata-rata',
                      value: '${(_allEmployeeLocations.where((e) => e['speedKmh'] > 0).fold<double>(0, (sum, e) => sum + e['speedKmh']) / (_allEmployeeLocations.where((e) => e['speedKmh'] > 0).length).clamp(1, double.infinity)).toStringAsFixed(1)} km/h',
                      color: Colors.white,
                    ),
                  ],
                ),
                if (totalGpsOff > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.gps_off, size: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '$totalGpsOff karyawan dengan GPS mati',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          const Icon(Icons.warning, size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Map placeholder
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 48, color: Colors.grey.shade400),
                const SizedBox(height: 8),
                Text(
                  'Live Location Map',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  '${filteredEmployees.length} karyawan terlihat',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Real-time tracking in Phase 4',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          
          // Search and filter
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Search bar
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari karyawan...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Speed filter
                      FilterChip(
                        label: const Text('Semua'),
                        selected: _speedFilter == 'Semua' && _gpsFilter == 'Semua',
                        onSelected: (_) {
                          setState(() {
                            _speedFilter = 'Semua';
                            _gpsFilter = 'Semua';
                          });
                        },
                        selectedColor: AppColors.adminPrimary.withValues(alpha: 0.2),
                        checkmarkColor: AppColors.adminPrimary,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('🚶 Diam'),
                        selected: _speedFilter == 'Diam',
                        onSelected: (_) {
                          setState(() {
                            _speedFilter = 'Diam';
                            _gpsFilter = 'Semua';
                          });
                        },
                        selectedColor: AppColors.adminPrimary.withValues(alpha: 0.2),
                        checkmarkColor: AppColors.adminPrimary,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('🛵 Bergerak'),
                        selected: _speedFilter == 'Jalan',
                        onSelected: (_) {
                          setState(() {
                            _speedFilter = 'Jalan';
                            _gpsFilter = 'Semua';
                          });
                        },
                        selectedColor: AppColors.adminPrimary.withValues(alpha: 0.2),
                        checkmarkColor: AppColors.adminPrimary,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('🚗 Cepat'),
                        selected: _speedFilter == 'Cepat',
                        onSelected: (_) {
                          setState(() {
                            _speedFilter = 'Cepat';
                            _gpsFilter = 'Semua';
                          });
                        },
                        selectedColor: AppColors.adminPrimary.withValues(alpha: 0.2),
                        checkmarkColor: AppColors.adminPrimary,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.gps_fixed, size: 14),
                            SizedBox(width: 4),
                            Text('GPS ON'),
                          ],
                        ),
                        selected: _gpsFilter == 'ON',
                        onSelected: (_) {
                          setState(() {
                            _gpsFilter = 'ON';
                            _speedFilter = 'Semua';
                          });
                        },
                        selectedColor: Colors.green.withValues(alpha: 0.2),
                        checkmarkColor: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.gps_off, size: 14),
                            SizedBox(width: 4),
                            Text('GPS OFF'),
                          ],
                        ),
                        selected: _gpsFilter == 'OFF',
                        onSelected: (_) {
                          setState(() {
                            _gpsFilter = 'OFF';
                            _speedFilter = 'Semua';
                          });
                        },
                        selectedColor: Colors.red.withValues(alpha: 0.2),
                        checkmarkColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Employee list with GPS status
          Expanded(
            child: filteredEmployees.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_off, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada karyawan ditemukan',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: filteredEmployees.length,
                    itemBuilder: (context, index) {
                      final employee = filteredEmployees[index];
                      final speed = employee['speedKmh'] as double;
                      final speedColor = _getSpeedColor(speed);
                      final speedIcon = _getSpeedIcon(speed);
                      final isGpsOff = employee['gpsStatus'] == 'OFF';
                      final isTrackingActive = employee['trackingStatus'] == 'active';
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: isGpsOff && employee['checkedIn'] == true
                              ? BorderSide(color: Colors.red.shade300, width: 1.5)
                              : BorderSide.none,
                        ),
                        child: InkWell(
                          onTap: () {
                            _showEmployeeDetail(context, employee);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // Avatar
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: isGpsOff ? Colors.grey.shade300 : AppColors.adminSoft,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          employee['name'][0],
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: isGpsOff ? Colors.grey : AppColors.adminPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    
                                    // Name and address
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  employee['name'],
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              // GPS Status Badge
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isGpsOff
                                                      ? Colors.red.withValues(alpha: 0.1)
                                                      : Colors.green.withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      isGpsOff ? Icons.gps_off : Icons.gps_fixed,
                                                      size: 10,
                                                      color: isGpsOff ? Colors.red : Colors.green,
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      isGpsOff ? 'GPS OFF' : 'GPS ON',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.w500,
                                                        color: isGpsOff ? Colors.red : Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Tracking Status Badge
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isTrackingActive
                                                      ? Colors.blue.withValues(alpha: 0.1)
                                                      : Colors.grey.withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      isTrackingActive
                                                          ? Icons.play_arrow
                                                          : Icons.stop,
                                                      size: 10,
                                                      color: isTrackingActive ? Colors.blue : Colors.grey,
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      isTrackingActive ? 'Tracking' : 'Stopped',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.w500,
                                                        color: isTrackingActive ? Colors.blue : Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on,
                                                  size: 12, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  employee['address'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Speed indicator
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: speedColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: speedColor.withValues(alpha: 0.3)),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '$speedIcon ${speed.toStringAsFixed(1)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: speedColor,
                                            ),
                                          ),
                                          Text(
                                            'km/h',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: speedColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 8),
                                
                                // Additional info row
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    // Check-in time
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.login, size: 10, color: AppColors.success),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${employee['checkedInTime'] ?? '--:--'}',
                                            style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Battery info
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            employee['batteryLevel'] > 50 ? Icons.battery_full : Icons.battery_alert,
                                            size: 10,
                                            color: employee['batteryLevel'] > 50 ? Colors.green : Colors.orange,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${employee['batteryLevel']}%',
                                            style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Last update
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.access_time, size: 10, color: Colors.grey.shade500),
                                          const SizedBox(width: 2),
                                          Text(
                                            employee['lastUpdate'],
                                            style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Working hours
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.schedule, size: 10, color: Colors.grey.shade500),
                                          const SizedBox(width: 2),
                                          Text(
                                            employee['workingHours'],
                                            style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                // GPS Warning for employees with GPS off
                                if (isGpsOff && employee['checkedIn'] == true)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.warning, size: 14, color: Colors.red),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'GPS mati - tidak dapat melacak lokasi',
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          const EnterpriseBadge(),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Memperbarui lokasi...')),
          );
        },
        backgroundColor: AppColors.adminPrimary,
        child: const Icon(Icons.my_location),
      ),
    );
  }

  void _showEmployeeDetail(BuildContext context, Map<String, dynamic> employee) {
    final speed = employee['speedKmh'] as double;
    final isGpsOff = employee['gpsStatus'] == 'OFF';
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.adminSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      employee['name'][0],
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.adminPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        employee['email'],
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            
            // GPS & Tracking Status Section
            Text(
              'Status Tracking',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isGpsOff ? Colors.red.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isGpsOff ? Colors.red.withValues(alpha: 0.3) : Colors.green.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DetailItem(
                        label: 'GPS',
                        value: employee['gpsStatus'],
                        icon: isGpsOff ? Icons.gps_off : Icons.gps_fixed,
                        color: isGpsOff ? Colors.red : Colors.green,
                      ),
                      _DetailItem(
                        label: 'Tracking',
                        value: employee['trackingStatus'] == 'active' ? 'Aktif' : 'Berhenti',
                        icon: employee['trackingStatus'] == 'active' ? Icons.play_arrow : Icons.stop,
                        color: employee['trackingStatus'] == 'active' ? Colors.blue : Colors.grey,
                      ),
                      _DetailItem(
                        label: 'Kecepatan',
                        value: '${speed.toStringAsFixed(1)} km/h',
                        icon: Icons.speed,
                        color: AppColors.adminPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Schedule Info
            Text(
              'Jadwal Kerja',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Jam Kerja:'),
                      Text(
                        employee['workingHours'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tracking Berjalan:'),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: employee['trackingStatus'] == 'active'
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            employee['trackingStatus'] == 'active'
                                ? 'Ya (dalam jam kerja)'
                                : 'Tidak (di luar jam kerja atau sudah pulang)',
                            style: TextStyle(
                              fontSize: 12,
                              color: employee['trackingStatus'] == 'active' ? Colors.green : Colors.grey,
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Enterprise Features Notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, size: 20, color: Colors.amber),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fitur Enterprise',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          'Background tracking, GPS status monitoring, dan notifikasi real-time tersedia di paket Enterprise',
                          style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur tracking map akan datang di Phase 4')),
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text('Lihat di Maps'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminPrimary,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.9)),
        ),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _DetailItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}