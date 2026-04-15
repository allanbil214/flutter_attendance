import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class AttendanceButtonPair extends StatelessWidget {
  final VoidCallback onCheckIn;
  final VoidCallback onCheckOut;
  final String? checkInTime;
  final String? checkOutTime;
  final bool isCheckedIn;
  final bool isCheckedOut;

  const AttendanceButtonPair({
    super.key,
    required this.onCheckIn,
    required this.onCheckOut,
    this.checkInTime,
    this.checkOutTime,
    this.isCheckedIn = false,
    this.isCheckedOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AttendanceButton(
            title: 'Masuk',
            icon: Icons.login,
            time: checkInTime,
            isActive: !isCheckedIn,
            color: AppColors.success,
            onTap: onCheckIn,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _AttendanceButton(
            title: 'Pulang',
            icon: Icons.logout,
            time: checkOutTime,
            isActive: isCheckedIn && !isCheckedOut,
            color: AppColors.warning,
            onTap: onCheckOut,
          ),
        ),
      ],
    );
  }
}

class _AttendanceButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? time;
  final bool isActive;
  final Color color;
  final VoidCallback onTap;

  const _AttendanceButton({
    required this.title,
    required this.icon,
    this.time,
    required this.isActive,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? color : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (isActive ? color : Colors.grey).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isActive ? color : Colors.grey,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? color : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time ?? '--:--',
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}