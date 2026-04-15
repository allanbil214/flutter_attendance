import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'enterprise_badge.dart';

class TrackingStatusIndicator extends StatelessWidget {
  final bool hasCheckedIn;
  final bool hasCheckedOut;
  final String? checkinTime;
  final String? checkoutTime;
  final bool showEnterpriseBadge;
  final String? workingHoursStart;
  final String? workingHoursEnd;

  const TrackingStatusIndicator({
    super.key,
    required this.hasCheckedIn,
    required this.hasCheckedOut,
    this.checkinTime,
    this.checkoutTime,
    this.showEnterpriseBadge = false,
    this.workingHoursStart = '08:00',
    this.workingHoursEnd = '16:00',
  });

  @override
  Widget build(BuildContext context) {
    final isTrackingActive = hasCheckedIn && !hasCheckedOut;
    final isWithinWorkingHours = true;
    
    return Container(
      padding: const EdgeInsets.all(12), // Reduced from 16
      decoration: BoxDecoration(
        color: isTrackingActive 
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isTrackingActive 
              ? Colors.green.withValues(alpha: 0.3)
              : Colors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isTrackingActive ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isTrackingActive ? Icons.play_arrow : Icons.stop,
                  size: 12,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTrackingActive ? 'Tracking Aktif' : 'Tracking Tidak Aktif',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      isTrackingActive
                          ? 'Lokasi Anda sedang dilacak'
                          : 'Tracking berhenti - sudah absen pulang',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (showEnterpriseBadge) const EnterpriseBadge(),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Jam Kerja:', style: TextStyle(fontSize: 11)),
              Text(
                '$workingHoursStart - $workingHoursEnd',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tracking Berjalan:', style: TextStyle(fontSize: 11)),
              Row(
                children: [
                  Icon(
                    isWithinWorkingHours ? Icons.check_circle : Icons.cancel,
                    size: 12,
                    color: isWithinWorkingHours ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    isWithinWorkingHours ? 'Ya' : 'Tidak',
                    style: TextStyle(
                      fontSize: 10,
                      color: isWithinWorkingHours ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (hasCheckedIn && !hasCheckedOut)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 12, color: Colors.blue),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Tracking akan berhenti setelah absen pulang',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}