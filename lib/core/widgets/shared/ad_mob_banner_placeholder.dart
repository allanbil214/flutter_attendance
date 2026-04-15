import 'package:flutter/material.dart';

class AdMobBannerPlaceholder extends StatelessWidget {
  const AdMobBannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.grey.shade100,
      child: const Center(
        child: Text(
          'AdMob Banner',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}