import 'package:flutter/material.dart';

import '../../../product_comparison/domain/models/comparison_product.dart';
import '../../../product_comparison/domain/models/dummy_data.dart';
import '../../../product_comparison/presentation/pages/product_compare_page.dart';

class ScanResultPage extends StatefulWidget {
  final ComparisonProduct scannedProduct; // 追加

  const ScanResultPage({
    super.key,
    required this.scannedProduct,
  });

  @override
  State<ScanResultPage> createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('スキャン結果'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 商品情報カード
            _buildProductInfoCard(),
            const SizedBox(height: 16),

            // 環境影響スコア
            _buildEnvironmentalScoreSection(),
            const SizedBox(height: 16),

            // 詳細情報
            _buildDetailedInfoSection(),
            const SizedBox(height: 24),

            // 代替商品ボタン
            _buildAlternativeProductButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '商品名',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('メーカー名'),
            const SizedBox(height: 4),
            const Text('カテゴリ: 食品'),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentalScoreSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '環境影響スコア',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // スコアの円形表示
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF008080),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // スコアバー
                Expanded(
                  child: Column(
                    children: [
                      _buildScoreBar('CO2排出量'),
                      const SizedBox(height: 8),
                      _buildScoreBar('包装'),
                      const SizedBox(height: 8),
                      _buildScoreBar('輸送距離'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double value) {
    if (value >= 0.7) {
      return const Color(0xFF008080); // ティール（良い）
    } else if (value >= 0.4) {
      return const Color(0xFFFFA500); // オレンジ（中間）
    } else {
      return const Color(0xFFFF4444); // 赤（悪い）
    }
  }

  Widget _buildScoreBar(String label) {
    // テスト用のダミー値（実際はデータから取得）
    final Map<String, double> scores = {
      'CO2排出量': 0.8,
      '包装': 0.5,
      '輸送距離': 0.3,
    };

    final value = scores[label] ?? 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade200,
          color: _getScoreColor(value),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildDetailedInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '詳細情報',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('CO2排出量'),
                Text(
                  '1.23 kg',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('包装'),
                Text(
                  'リサイクル可能',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('輸送距離'),
                Text(
                  '100 km',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeProductButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductComparePage(
                productA: widget.scannedProduct,
                productB: DummyProducts.productB,
              ), // テスト用),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF008080),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          '代替商品を表示',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
