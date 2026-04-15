import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class EnterpriseBadge extends StatelessWidget {
  final bool showLock;
  final String? text;
  
  const EnterpriseBadge({
    super.key,
    this.showLock = true,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade600, Colors.amber.shade800],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLock) ...[
            const Icon(Icons.star, size: 10, color: Colors.white),
            const SizedBox(width: 2),
          ],
          Text(
            text ?? 'Enterprise',
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}