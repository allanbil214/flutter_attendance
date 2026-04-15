import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  DateTime _selectedDate = DateTime.now();
  
  final List<Map<String, dynamic>> _attendanceList = [
    {
      'name': 'Siti Aminah',
      'date': '2026-04-14',
      'checkin': '07:02',
      'checkout': '15:05',
      'status': 'Hadir',
    },
    {
      'name': 'Budi Santoso',
      'date': '2026-04-14',
      'checkin': '06:55',
      'checkout': '15:00',
      'status': 'Hadir',
    },
    {
      'name': 'Andi Firmansyah',
      'date': '2026-04-14',
      'checkin': '07:15',
      'checkout': '15:00',
      'status': 'Terlambat',
    },
  ];

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Presensi'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
      ),
      body: Column(
        children: [
          // Date picker
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: InkWell(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.adminPrimary),
                    const SizedBox(width: 12),
                    Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
          
          // Summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.adminSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryItem(
                  title: 'Total Karyawan',
                  value: '3',
                  icon: Icons.people,
                ),
                _SummaryItem(
                  title: 'Hadir',
                  value: '2',
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
                _SummaryItem(
                  title: 'Terlambat',
                  value: '1',
                  icon: Icons.warning,
                  color: AppColors.warning,
                ),
              ],
            ),
          ),
          
          // Attendance list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _attendanceList.length,
              itemBuilder: (context, index) {
                final item = _attendanceList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.adminSoft,
                      child: Icon(Icons.person, color: AppColors.adminPrimary),
                    ),
                    title: Text(item['name']),
                    subtitle: Text('Masuk: ${item['checkin']} | Pulang: ${item['checkout']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: item['status'] == 'Hadir'
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item['status'],
                        style: TextStyle(
                          color: item['status'] == 'Hadir' ? AppColors.success : AppColors.warning,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () {
                      // Show detail
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color ?? AppColors.adminPrimary, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}