import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MapPlaceholder extends StatelessWidget {
  final VoidCallback? onLocationSelected;
  final double? latitude;
  final double? longitude;

  const MapPlaceholder({
    super.key,
    this.onLocationSelected,
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          if (latitude != null && longitude != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Lat: $latitude, Lng: $longitude',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          const SizedBox(height: 12),
          if (onLocationSelected != null)
            ElevatedButton(
              onPressed: onLocationSelected,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Pilih Lokasi'),
            ),
        ],
      ),
    );
  }
}