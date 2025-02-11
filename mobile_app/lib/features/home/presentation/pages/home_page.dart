import 'package:flutter/material.dart';
import 'package:mobile_app/features/product_comparison/domain/models/dummy_data.dart';
import 'package:mobile_app/features/product_comparison/presentation/pages/product_compare_page.dart';
import '../../../barcode_scan/presentation/pages/barcode_scan_page.dart';
import '../../domain/models/recent_scan.dart';
import '../widgets/recent_scans_list.dart';
import '../widgets/scan_button.dart';
import '../../../product_comparison/domain/models/dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Creating sample data
  List<RecentScan> _getRecentScans() {
    return [
      RecentScan(
          productName: 'productA',
          manufacturer: 'manufacturerA',
          score: 'A',
          scannedAt: DateTime.now()),
      RecentScan(
          productName: 'productB',
          manufacturer: 'manufacturerB',
          score: 'B',
          scannedAt: DateTime.now().subtract(const Duration(days: 1))),
    ];
  }

  void _onScanPressed() {
    debugPrint('Scan button pressed');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BarcodeScanPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recentScans = _getRecentScans();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epsilon'),
        centerTitle: true,
        actions: [
          // テスト用の比較画面遷移ボタン
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductComparePage(
                    productA: DummyProducts.productA,
                    productB: DummyProducts.productB,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: ScanButton(
              onPressed: _onScanPressed,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Scans',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RecentScansList(recentScans: recentScans),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
