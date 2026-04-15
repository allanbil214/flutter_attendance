import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class EmployeeCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String? employeeId;
  final VoidCallback onEdit;
  final String? photoUrl;

  const EmployeeCardWidget({
    super.key,
    required this.name,
    required this.email,
    this.employeeId,
    required this.onEdit,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.person, size: 30, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Email
            Text(
              email,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (employeeId != null)
              Text(
                'ID: $employeeId',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            const SizedBox(height: 8),
            // Edit button
            OutlinedButton(
              onPressed: onEdit,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 32),
                padding: EdgeInsets.zero,
              ),
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}