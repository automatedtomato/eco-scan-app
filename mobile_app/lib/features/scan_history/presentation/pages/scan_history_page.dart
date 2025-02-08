import 'package:flutter/material.dart';
import '../../domain/models/scan_history_item.dart';

class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  // テスト用のサンプルデータ
  List<ScanHistoryItem> _getSampleHistory() {
    return [
      ScanHistoryItem(
        productName: '商品名A',
        manufacturer: 'メーカー名',
        score: 'A',
        scannedAt: DateTime(2024, 2, 6),
      ),
      ScanHistoryItem(
        productName: '商品名B',
        manufacturer: 'メーカー名',
        score: 'B',
        scannedAt: DateTime(2024, 2, 5),
      ),
      ScanHistoryItem(
        productName: '商品名C',
        manufacturer: 'メーカー名',
        score: 'A',
        scannedAt: DateTime(2024, 2, 5),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final history = _getSampleHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('スキャン履歴'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: Column(
        children: [
          // 期間選択
          _buildPeriodSelector(),

          // 履歴リスト
          Expanded(
            child: _buildHistoryList(history),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('期間：'),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('今月'),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<ScanHistoryItem> history) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];

        // 日付が変わる場合に日付ヘッダーを表示
        final showDateHeader = index == 0 ||
            item.formattedDate != history[index - 1].formattedDate;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showDateHeader) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  item.formattedDate,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            _buildHistoryItem(item),
          ],
        );
      },
    );
  }

  Widget _buildHistoryItem(ScanHistoryItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.manufacturer,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getScoreColor(item.score),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  item.score,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(String score) {
    switch (score) {
      case 'A':
        return const Color(0xFF008080);
      case 'B':
        return const Color(0xFF3CB371);
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.orangeAccent;
      case 'E':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
