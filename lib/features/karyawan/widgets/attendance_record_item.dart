import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';

class AttendanceRecordItem extends StatelessWidget {
  final dynamic record;

  const AttendanceRecordItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (record.status) {
      case 'Hadir':
        statusColor = AppColors.success;
        break;
      case 'Terlambat':
        statusColor = AppColors.warning;
        break;
      case 'Pulang Awal':
        statusColor = AppColors.error;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          context.push('/detail-presensi', extra: record);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: statusColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.date,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.login, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          record.checkin,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.logout, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          record.checkout,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  record.status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// Add these fields to the AttendanceRecord class in attendance_record_item.dart
class AttendanceRecord {
  final String date;
  final String checkin;
  final String checkout;
  final String status;
  final int? lateMinutes;
  final int? earlyMinutes;
  final String? checkinAddress;
  final String? checkoutAddress;
  final String? checkinPhoto;
  final String? checkoutPhoto;

  AttendanceRecord({
    required this.date,
    required this.checkin,
    required this.checkout,
    required this.status,
    this.lateMinutes,
    this.earlyMinutes,
    this.checkinAddress,
    this.checkoutAddress,
    this.checkinPhoto,
    this.checkoutPhoto,
  });
}