import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/local/shared_prefs_helper.dart';
import '../../../data/datasources/remote/api_client.dart';

class OrganisasiScreen extends StatefulWidget {
  const OrganisasiScreen({super.key});

  @override
  State<OrganisasiScreen> createState() => _OrganisasiScreenState();
}

class _OrganisasiScreenState extends State<OrganisasiScreen> {
  // Dummy org data
  final Map<String, dynamic> _orgData = {
    'name': 'PT Barani Multi Teknologi',
    'email': 'baranimultiteknologi@gmail.com',
    'phone': '082233445566',
    'address': 'Jl. Kali Baru No.28, Bekasi Barat, Jawa Barat',
    'employeeCount': 5,
    'subscription': 'Growth Plan',
    'expiresAt': '2026-09-14',
    'coinBalance': 120,
  };

  void _shareOrgId() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ID Organisasi: ORG_001 (Demo)')),
    );
  }

  Future<void> _logout() async {
    // Call logout API
    final apiClient = ApiClient();
    await apiClient.logout();
    
    // Clear admin session
    await SharedPrefsHelper.clearAdminSession();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda telah logout'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/login-method');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisasi'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.adminGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Logo placeholder
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.adminSoft,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.adminPrimary, width: 2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.business,
                    size: 50,
                    color: AppColors.adminPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Org name
            Text(
              _orgData['name'],
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(icon: Icons.email, label: 'Email', value: _orgData['email']),
                    const Divider(),
                    _InfoRow(icon: Icons.phone, label: 'Telepon', value: _orgData['phone']),
                    const Divider(),
                    _InfoRow(icon: Icons.location_on, label: 'Alamat', value: _orgData['address']),
                    const Divider(),
                    _InfoRow(icon: Icons.people, label: 'Jumlah Karyawan', value: '${_orgData['employeeCount']}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Subscription card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.subscriptions, color: AppColors.adminPrimary),
                        SizedBox(width: 8),
                        Text(
                          'Langganan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Paket:'),
                        Text(
                          _orgData['subscription'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Berlaku hingga:'),
                        Text(_orgData['expiresAt']),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey.shade200,
                      color: AppColors.adminPrimary,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Koin tersedia:'),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${_orgData['coinBalance']}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _shareOrgId,
                    icon: const Icon(Icons.share),
                    label: const Text('Bagikan ID'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout', style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.adminPrimary),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}