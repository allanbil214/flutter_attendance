#!/usr/bin/env python3
"""
SmartPresensi Flutter Project Structure Generator
Run this script from your Flutter project root directory
"""

import os
import sys

# Project root directory (current directory where script is run)
PROJECT_ROOT = os.getcwd()

# Folders to create (relative to lib/)
FOLDERS = [
    # App level
    "app",
    
    # Core
    "core/constants",
    "core/themes",
    "core/utils",
    "core/widgets/shared",
    "core/widgets/dialogs",
    
    # Features - Auth
    "features/auth/providers",
    
    # Features - Splash & Onboarding
    "features/splash/providers",
    "features/onboarding/widgets",
    
    # Features - Karyawan
    "features/karyawan/home",
    "features/karyawan/kegiatan_list",
    "features/karyawan/presensi",
    "features/karyawan/upload",
    "features/karyawan/profile",
    "features/karyawan/widgets",
    
    # Features - Admin
    "features/admin/home",
    "features/admin/kegiatan",
    "features/admin/karyawan",
    "features/admin/laporan",
    "features/admin/tracking",
    "features/admin/organisasi",
    "features/admin/notifikasi",
    "features/admin/widgets",
    
    # Features - Personal
    "features/personal/widgets",
    
    # Features - Settings
    "features/settings",
    
    # Data layer
    "data/models",
    "data/repositories",
    "data/datasources/local",
    "data/datasources/remote",
    "data/providers",
    
    # Services
    "services",
]

# Files to create (relative to lib/)
FILES = [
    # App level
    "app/app.dart",
    "app/app_router.dart",
    
    # Core constants
    "core/constants/app_constants.dart",
    "core/constants/api_endpoints.dart",
    "core/constants/colors.dart",
    
    # Core themes
    "core/themes/app_theme.dart",
    
    # Core utils
    "core/utils/extensions.dart",
    "core/utils/formatters.dart",
    "core/utils/validators.dart",
    
    # Core shared widgets
    "core/widgets/shared/header_card_widget.dart",
    "core/widgets/shared/employee_card_widget.dart",
    "core/widgets/shared/kegiatan_card_widget.dart",
    "core/widgets/shared/attendance_button_pair.dart",
    "core/widgets/shared/custom_snackbar.dart",
    "core/widgets/shared/loading_dialog.dart",
    "core/widgets/shared/map_placeholder.dart",
    
    # Core dialogs
    "core/widgets/dialogs/fake_gps_dialog.dart",
    "core/widgets/dialogs/root_detected_dialog.dart",
    "core/widgets/dialogs/forgot_password_dialog.dart",
    "core/widgets/dialogs/join_kegiatan_dialog.dart",
    "core/widgets/dialogs/delete_confirm_dialog.dart",
    "core/widgets/dialogs/photo_zoom_dialog.dart",
    "core/widgets/dialogs/update_available_dialog.dart",
    "core/widgets/dialogs/tutorial_dialog.dart",
    "core/widgets/dialogs/internet_error_dialog.dart",
    "core/widgets/dialogs/user_info_dialog.dart",
    "core/widgets/dialogs/pick_kegiatan_bottom_sheet.dart",
    
    # Splash
    "features/splash/splash_screen.dart",
    "features/splash/providers/splash_provider.dart",
    
    # Onboarding
    "features/onboarding/onboarding_screen.dart",
    "features/onboarding/widgets/onboarding_item.dart",
    
    # Auth
    "features/auth/login_method_screen.dart",
    "features/auth/login_karyawan_screen.dart",
    "features/auth/login_perusahaan_screen.dart",
    "features/auth/personal_login_screen.dart",
    "features/auth/register_screen.dart",
    "features/auth/ganti_password_screen.dart",
    "features/auth/providers/auth_provider.dart",
    
    # Karyawan - Home
    "features/karyawan/home/karyawan_home_screen.dart",
    
    # Karyawan - Kegiatan List
    "features/karyawan/kegiatan_list/kegiatan_list_page.dart",
    
    # Karyawan - Presensi
    "features/karyawan/presensi/presensi_page.dart",
    "features/karyawan/presensi/maps_presensi_screen.dart",
    "features/karyawan/presensi/swafoto_screen.dart",
    "features/karyawan/presensi/detail_presensi_screen.dart",
    
    # Karyawan - Upload
    "features/karyawan/upload/upload_foto_screen.dart",
    "features/karyawan/upload/upload_aktivitas_screen.dart",
    
    # Karyawan - Profile
    "features/karyawan/profile/profile_page.dart",
    
    # Karyawan - Widgets
    "features/karyawan/widgets/kegiatan_card.dart",
    "features/karyawan/widgets/attendance_record_item.dart",
    
    # Admin - Home
    "features/admin/home/admin_home_screen.dart",
    
    # Admin - Kegiatan
    "features/admin/kegiatan/input_kegiatan_screen.dart",
    "features/admin/kegiatan/edit_kegiatan_screen.dart",
    
    # Admin - Karyawan
    "features/admin/karyawan/karyawan_list_screen.dart",
    "features/admin/karyawan/input_karyawan_screen.dart",
    "features/admin/karyawan/edit_karyawan_screen.dart",
    
    # Admin - Laporan
    "features/admin/laporan/laporan_screen.dart",
    
    # Admin - Tracking
    "features/admin/tracking/tracking_maps_screen.dart",
    
    # Admin - Organisasi
    "features/admin/organisasi/organisasi_screen.dart",
    
    # Admin - Notifikasi
    "features/admin/notifikasi/kirim_notif_screen.dart",
    
    # Admin - Widgets
    "features/admin/widgets/admin_kegiatan_card.dart",
    "features/admin/widgets/karyawan_card.dart",
    
    # Personal
    "features/personal/personal_home_screen.dart",
    "features/personal/personal_upload_screen.dart",
    "features/personal/galeri_aktivitas_screen.dart",
    "features/personal/widgets/aktivitas_card.dart",
    
    # Settings
    "features/settings/settings_screen.dart",
    "features/settings/about_screen.dart",
    "features/settings/terms_screen.dart",
    "features/settings/qris_screen.dart",
    "features/settings/webview_screen.dart",
    "features/settings/version_screen.dart",
    
    # Data - Models
    "data/models/user_model.dart",
    "data/models/organization_model.dart",
    "data/models/activity_model.dart",
    "data/models/attendance_model.dart",
    "data/models/sop_item_model.dart",
    "data/models/group_model.dart",
    
    # Data - Repositories
    "data/repositories/auth_repository.dart",
    "data/repositories/attendance_repository.dart",
    "data/repositories/activity_repository.dart",
    "data/repositories/user_repository.dart",
    
    # Data - Datasources
    "data/datasources/local/shared_prefs_helper.dart",
    "data/datasources/local/session_manager.dart",
    "data/datasources/remote/api_client.dart",
    "data/datasources/remote/api_service.dart",
    "data/datasources/remote/endpoints.dart",
    
    # Data - Providers
    "data/providers/session_provider.dart",
    "data/providers/current_activity_provider.dart",
    "data/providers/notification_provider.dart",
    
    # Services
    "services/location_service.dart",
    "services/camera_service.dart",
    "services/notification_service.dart",
    "services/background_tracking_service.dart",
    "services/permission_service.dart",
]

# Directories to create under assets/
ASSETS_FOLDERS = [
    "assets/images",
    "assets/icons",
    "assets/illustrations",
]


def create_directory(path):
    """Create directory if it doesn't exist"""
    full_path = os.path.join(PROJECT_ROOT, path)
    if not os.path.exists(full_path):
        os.makedirs(full_path)
        print(f"✅ Created directory: {path}")
        return True
    else:
        print(f"⏭️  Directory already exists: {path}")
        return False


def create_file(path, content=""):
    """Create file with optional content"""
    full_path = os.path.join(PROJECT_ROOT, path)
    dir_path = os.path.dirname(full_path)
    
    # Ensure parent directory exists
    if dir_path and not os.path.exists(dir_path):
        os.makedirs(dir_path)
        print(f"✅ Created directory: {dir_path}")
    
    # Create file if it doesn't exist
    if not os.path.exists(full_path):
        with open(full_path, 'w', encoding='utf-8') as f:
            if content:
                f.write(content)
        print(f"✅ Created file: {path}")
        return True
    else:
        print(f"⏭️  File already exists: {path}")
        return False


def main():
    print("=" * 60)
    print("SmartPresensi Flutter Project Structure Generator")
    print("=" * 60)
    print(f"Project root: {PROJECT_ROOT}\n")
    
    # Check if we're in a Flutter project
    if not os.path.exists(os.path.join(PROJECT_ROOT, "pubspec.yaml")):
        print("⚠️  Warning: pubspec.yaml not found in current directory.")
        response = input("Are you sure you want to continue? (y/N): ")
        if response.lower() != 'y':
            print("❌ Exiting...")
            sys.exit(1)
    
    # Create lib directory if it doesn't exist
    lib_path = os.path.join(PROJECT_ROOT, "lib")
    if not os.path.exists(lib_path):
        os.makedirs(lib_path)
        print(f"✅ Created directory: lib/")
    
    # Create folders
    print("\n📁 Creating folders...")
    for folder in FOLDERS:
        create_directory(f"lib/{folder}")
    
    # Create files
    print("\n📄 Creating files...")
    for file in FILES:
        create_file(f"lib/{file}")
    
    # Create asset folders
    print("\n🎨 Creating asset folders...")
    for folder in ASSETS_FOLDERS:
        create_directory(folder)
    
    # Create main.dart if it doesn't exist
    main_dart_content = '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SmartPresensiApp()));
}
'''
    create_file("lib/main.dart", main_dart_content)
    
    # Create app.dart if it doesn't exist
    app_dart_content = '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';
import '../core/themes/app_theme.dart';

class SmartPresensiApp extends ConsumerStatefulWidget {
  const SmartPresensiApp({super.key});

  @override
  ConsumerState<SmartPresensiApp> createState() => _SmartPresensiAppState();
}

class _SmartPresensiAppState extends ConsumerState<SmartPresensiApp> {
  final _router = AppRouter().router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SmartPresensi',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
'''
    create_file("lib/app/app.dart", app_dart_content)
    
    # Create app_router.dart if it doesn't exist
    router_content = '''import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: '/splash',
        routes: [
          GoRoute(
            path: '/splash',
            name: 'splash',
            builder: (context, state) => const SplashScreen(),
          ),
          // Other routes will be added in Phase 1
        ],
      );
}
'''
    create_file("lib/app/app_router.dart", router_content)
    
    # Create app_theme.dart if it doesn't exist
    theme_content = '''import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
'''
    create_file("lib/core/themes/app_theme.dart", theme_content)
    
    # Create colors.dart if it doesn't exist
    colors_content = '''import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1F8B4C);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF156C3A);
  
  // Admin colors
  static const Color adminPrimary = Color(0xFFF57C00);
  static const Color adminLight = Color(0xFFFF9800);
  static const Color adminDark = Color(0xFFE65100);
  
  // Personal colors
  static const Color personalPrimary = Color(0xFF00838F);
  static const Color personalLight = Color(0xFF00BCD4);
  
  // Neutral colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textLight = Colors.white;
}
'''
    create_file("lib/core/constants/colors.dart", colors_content)
    
    # Create splash_screen.dart if it doesn't exist
    splash_content = '''import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      // TODO: Check if first launch
      // For Phase 1, always go to onboarding
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Add app logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'SmartPresensi',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(height: 8),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
'''
    create_file("lib/features/splash/splash_screen.dart", splash_content)
    
    print("\n" + "=" * 60)
    print("✅ Project structure generation complete!")
    print("=" * 60)
    print("\nNext steps:")
    print("1. Run 'flutter pub get' to install dependencies")
    print("2. Run 'flutter run' to test the app")
    print("3. Continue with Phase 1.1 - OnboardingScreen and LoginMethodScreen")
    print("\n📁 Total folders created: {}")
    print("📄 Total files created: {}")
    print("=" * 60)


if __name__ == "__main__":
    main()