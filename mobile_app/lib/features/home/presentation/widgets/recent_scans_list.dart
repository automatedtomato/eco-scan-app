// lib/features/home/presentation/widgets/recent_scans_list.dart
import 'package:flutter/material.dart';
import '../../domain/models/recent_scan.dart';

class RecentScansList extends StatelessWidget {
  final List<RecentScan> recentScans;

  const RecentScansList({
    super.key,
    required this.recentScans,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recentScans.map((scan) => _buildScanItem(scan)).toList(),
    );
  }

  Widget _buildScanItem(RecentScan scan) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getScoreColor(scan.score),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                scan.score,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                  scan.productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  scan.manufacturer,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(String score) {
    switch (score) {
      case 'A':
        return const Color(0xFF008080); // ティール
      case 'B':
        return const Color(0xFF40A0A0); // 薄いティール
      default:
        return Colors.grey;
    }
  }
}
