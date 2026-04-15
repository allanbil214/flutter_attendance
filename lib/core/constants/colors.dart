import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF1F8B4C);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF156C3A);
  static const Color primarySoft = Color(0xFFE8F5E9);
  
  // Admin colors (orange theme)
  static const Color adminPrimary = Color(0xFFF57C00);
  static const Color adminLight = Color(0xFFFF9800);
  static const Color adminDark = Color(0xFFE65100);
  static const Color adminSoft = Color(0xFFFFF3E0);
  
  // Personal colors (teal theme)
  static const Color personalPrimary = Color(0xFF00838F);
  static const Color personalLight = Color(0xFF00BCD4);
  static const Color personalSoft = Color(0xFFE0F7FA);
  
  // Neutral colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surface = Colors.white;
  static const Color surfaceDark = Color(0xFFF5F5F5);
  
  // Semantic colors
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);
  
  // Text colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textHint = Color(0xFFBDC3C7);
  static const Color textLight = Colors.white;
  static const Color textDark = Color(0xFF1A252F);
  
  // Gradient colors
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );
  
  static const Gradient adminGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [adminPrimary, adminLight],
  );
  
  static const Gradient personalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [personalPrimary, personalLight],
  );
}