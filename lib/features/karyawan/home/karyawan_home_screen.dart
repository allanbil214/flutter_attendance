import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../kegiatan_list/kegiatan_list_page.dart';
import '../presensi/presensi_page.dart';
import '../profile/profile_page.dart';

class KaryawanHomeScreen extends StatefulWidget {
  const KaryawanHomeScreen({super.key});

  @override
  State<KaryawanHomeScreen> createState() => _KaryawanHomeScreenState();
}

class _KaryawanHomeScreenState extends State<KaryawanHomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const KegiatanListPage(),
    const PresensiPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view),
              label: 'Kegiatan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fingerprint_outlined),
              activeIcon: Icon(Icons.fingerprint),
              label: 'Presensi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}