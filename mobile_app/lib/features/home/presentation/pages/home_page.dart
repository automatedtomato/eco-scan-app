import 'package:flutter/material.dart';

import '../../domain/models/recent_scan.dart';
import '../widgets/recent_scans_list.dart';
import '../widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    // TODO: Implement scan functionality
    debugPrint('Scan button pressed');
  }

  @override
  Widget build(BuildContext context) {
    final recentScans = _getRecentScans();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epsilon'),
        centerTitle: true,
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
                SizedBox(height: 8),
                RecentScansList(recentScans: recentScans),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
