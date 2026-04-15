import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class QrisScreen extends StatefulWidget {
  const QrisScreen({super.key});

  @override
  State<QrisScreen> createState() => _QrisScreenState();
}

class _QrisScreenState extends State<QrisScreen> {
  int _coinBalance = 120;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _coinPackages = [
    {'coins': 50, 'price': 50000, 'saved': false},
    {'coins': 100, 'price': 100000, 'saved': false},
    {'coins': 250, 'price': 225000, 'saved': '10%'},
    {'coins': 500, 'price': 400000, 'saved': '20%'},
    {'coins': 1000, 'price': 700000, 'saved': '30%'},
  ];

  Future<void> _purchaseCoins(int coins, int price) async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _coinBalance += coins;
      _isProcessing = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil membeli $coins koin!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koin & Donasi'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Balance card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade600, Colors.amber.shade800],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Saldo Koin',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.white, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        '$_coinBalance',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Info text
            const Text(
              'Koin dapat digunakan untuk:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _InfoChip(icon: Icons.picture_as_pdf, label: 'Export Laporan PDF', coins: 5),
            _InfoChip(icon: Icons.download, label: 'Download Data CSV', coins: 3),
            _InfoChip(icon: Icons.email, label: 'Email Laporan', coins: 2),
            _InfoChip(icon: Icons.storage, label: 'Tambahan Storage 1GB', coins: 20),
            
            const SizedBox(height: 24),
            
            // Purchase section
            const Text(
              'Beli Koin',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Coin packages
            ..._coinPackages.map((pkg) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CoinPackageCard(
                coins: pkg['coins'],
                price: pkg['price'],
                saved: pkg['saved'],
                onPurchase: () => _purchaseCoins(pkg['coins'], pkg['price']),
                isProcessing: _isProcessing,
              ),
            )),
            
            const SizedBox(height: 16),
            
            // QRIS info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.qr_code, size: 32, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pembayaran via QRIS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Scan QR Code menggunakan aplikasi mobile banking',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final int coins;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$coins koin',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.amber.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinPackageCard extends StatelessWidget {
  final int coins;
  final int price;
  final dynamic saved;
  final VoidCallback onPurchase;
  final bool isProcessing;

  const _CoinPackageCard({
    required this.coins,
    required this.price,
    required this.saved,
    required this.onPurchase,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$coins',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$coins Koin',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (saved != false)
                    Text(
                      'Hemat $saved',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade600,
                      ),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 80,
                  height: 32,
                  child: ElevatedButton(
                    onPressed: isProcessing ? null : onPurchase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Beli'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}