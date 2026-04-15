import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';

class AktivitasCard extends StatelessWidget {
  final Map<String, dynamic> aktivitas;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const AktivitasCard({
    super.key,
    required this.aktivitas,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and delete button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      aktivitas['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: onDelete,
                    color: Colors.red,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Description
              Text(
                aktivitas['description'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              
              // Location
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: AppColors.personalPrimary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      aktivitas['location'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Date badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.personalSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, size: 10, color: AppColors.personalPrimary),
                        const SizedBox(width: 4),
                        Text(
                          aktivitas['date'],
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.personalPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Photo count
                  if ((aktivitas['photos'] as List).isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.photo_library, size: 12, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          '${(aktivitas['photos'] as List).length} foto',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}