import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/colors.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/login_method_screen.dart';
import '../features/karyawan/login/login_karyawan_screen.dart';
import '../features/karyawan/login/register_screen.dart';
import '../features/karyawan/home/karyawan_home_screen.dart';
import '../features/karyawan/presensi/presensi_page.dart';
import '../features/karyawan/presensi/maps_presensi_screen.dart';
import '../features/karyawan/presensi/swafoto_screen.dart';
import '../features/karyawan/presensi/detail_presensi_screen.dart';
import '../features/karyawan/upload/upload_foto_screen.dart';
import '../features/karyawan/upload/upload_aktivitas_screen.dart';
import '../features/karyawan/profile/ganti_password_screen.dart';

import '../features/admin/login/login_perusahaan_screen.dart';
import '../features/admin/home/admin_home_screen.dart';
import '../features/admin/kegiatan/input_kegiatan_screen.dart';
import '../features/admin/kegiatan/edit_kegiatan_screen.dart';
import '../features/admin/karyawan/karyawan_list_screen.dart';
import '../features/admin/karyawan/input_karyawan_screen.dart';
import '../features/admin/karyawan/edit_karyawan_screen.dart';
import '../features/admin/laporan/laporan_screen.dart';
import '../features/admin/tracking/tracking_maps_screen.dart';
import '../features/admin/organisasi/organisasi_screen.dart';
import '../features/admin/notifikasi/kirim_notif_screen.dart';

import '../features/personal/login/personal_login_screen.dart';
import '../features/personal/home/personal_home_screen.dart';
import '../features/personal/upload/personal_upload_screen.dart';
import '../features/personal/galeri/galeri_aktivitas_screen.dart';

import '../features/settings/about_screen.dart';
import '../features/settings/terms_screen.dart';
import '../features/settings/qris_screen.dart';
import '../features/settings/webview_screen.dart';
import '../features/settings/version_screen.dart';

import '../features/karyawan/settings/karyawan_settings_screen.dart';
import '../features/admin/settings/admin_settings_screen.dart';
import '../features/personal/settings/personal_settings_screen.dart';

// Temporary placeholders for Phase 1.2, 1.3, 1.4
// Remove these when actual screens are created

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: '/splash',
        routes: [
          // Splash route
          GoRoute(
            path: '/splash',
            name: 'splash',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SplashScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ),
          
          // Onboarding route
          GoRoute(
            path: '/onboarding',
            name: 'onboarding',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const OnboardingScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              },
            ),
          ),
          
          // Login method route
          GoRoute(
            path: '/login-method',
            name: 'login-method',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const LoginMethodScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                );
              },
            ),
          ),
          
          GoRoute(
            path: '/login-karyawan',
            name: 'login-karyawan',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const LoginKaryawanScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            path: '/register',
            name: 'register',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const RegisterScreen(),
            ),
          ),
          GoRoute(
            path: '/karyawan-home',
            name: 'karyawan-home',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const KaryawanHomeScreen(),
            ),
          ),
          GoRoute(
            path: '/presensi',
            name: 'presensi',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const PresensiPage(),
            ),
          ),
          GoRoute(
            path: '/maps-presensi',
            name: 'maps-presensi',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const MapsPresensiScreen(),
            ),
          ),
          GoRoute(
            path: '/swafoto',
            name: 'swafoto',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const SwafotoScreen(),
            ),
          ),
          GoRoute(
            path: '/detail-presensi',
            name: 'detail-presensi',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const DetailPresensiScreen(),
            ),
          ),
          GoRoute(
            path: '/upload-foto',
            name: 'upload-foto',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const UploadFotoScreen(),
            ),
          ),
          GoRoute(
            path: '/upload-aktivitas',
            name: 'upload-aktivitas',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const UploadAktivitasScreen(),
            ),
          ),
          GoRoute(
            path: '/ganti-password',
            name: 'ganti-password',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const GantiPasswordScreen(),
            ),
          ),
          GoRoute(
            path: '/login-perusahaan',
            name: 'login-perusahaan',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const LoginPerusahaanScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            path: '/admin-home',
            name: 'admin-home',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const AdminHomeScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-input-kegiatan',
            name: 'admin-input-kegiatan',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const InputKegiatanScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-edit-kegiatan',
            name: 'admin-edit-kegiatan',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const EditKegiatanScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-karyawan-list',
            name: 'admin-karyawan-list',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const KaryawanListScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-input-karyawan',
            name: 'admin-input-karyawan',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const InputKaryawanScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-edit-karyawan',
            name: 'admin-edit-karyawan',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const EditKaryawanScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-laporan',
            name: 'admin-laporan',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const LaporanScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-tracking',
            name: 'admin-tracking',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const TrackingMapsScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-organisasi',
            name: 'admin-organisasi',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const OrganisasiScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-kirim-notif',
            name: 'admin-kirim-notif',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const KirimNotifScreen(),
            ),
          ),
          GoRoute(
            path: '/personal-login',
            name: 'personal-login',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const PersonalLoginScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            path: '/personal-home',
            name: 'personal-home',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const PersonalHomeScreen(),
            ),
          ),
          GoRoute(
            path: '/personal-upload',
            name: 'personal-upload',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const PersonalUploadScreen(),
            ),
          ),
          GoRoute(
            path: '/personal-galeri',
            name: 'personal-galeri',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const GaleriAktivitasScreen(),
            ),
          ),

          GoRoute(
            path: '/about',
            name: 'about',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const AboutScreen(),
            ),
          ),
          GoRoute(
            path: '/terms',
            name: 'terms',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const TermsScreen(),
            ),
          ),
          GoRoute(
            path: '/qris',
            name: 'qris',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const QrisScreen(),
            ),
          ),
          GoRoute(
            path: '/webview',
            name: 'webview',
            pageBuilder: (context, state) {
              final args = state.extra as Map<String, String>;
              return MaterialPage(
                key: state.pageKey,
                child: WebViewScreen(
                  url: args['url'] ?? 'https://google.com',
                  title: args['title'] ?? 'WebView',
                ),
              );
            },
          ),
          GoRoute(
            path: '/version',
            name: 'version',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const VersionScreen(),
            ),
          ),

          GoRoute(
            path: '/karyawan-settings',
            name: 'karyawan-settings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const KaryawanSettingsScreen(),
            ),
          ),
          GoRoute(
            path: '/admin-settings',
            name: 'admin-settings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const AdminSettingsScreen(),
            ),
          ),
          GoRoute(
            path: '/personal-settings',
            name: 'personal-settings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const PersonalSettingsScreen(),
            ),
          ),

        // put router here lol
        ],
        errorPageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            body: Center(
              child: Text(
                'Page not found: ${state.uri}',
                style: const TextStyle(color: AppColors.error),
              ),
            ),
          ),
        ),
      );
}