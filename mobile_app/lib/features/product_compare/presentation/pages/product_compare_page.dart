import 'package:flutter/material.dart';

class ProductComparePage extends StatelessWidget {
  const ProductComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品比較'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 商品比較カード
            _buildProductComparisonCard(),
            const SizedBox(height: 24),

            // 比較分析
            _buildComparisonAnalysis(),
            const SizedBox(height: 24),

            // 総評
            _buildSummary(),
            const SizedBox(height: 24),

            // 選択ボタン
            _buildSelectButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductComparisonCard() {
    return Row(
      children: [
        // 商品A
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'メーカー名',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  // スコア表示
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF008080),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'CO2: 1.23kg',
                    style: TextStyle(fontSize: 12),
                  ),
                  const Text(
                    '輸送: 100km',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
        // VS表示
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: const Text(
            'VS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // 商品B
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'メーカー名',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3CB371),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'B',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'CO2: 2.34kg',
                    style: TextStyle(fontSize: 12),
                  ),
                  const Text(
                    '輸送: 150km',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '比較分析',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildComparisonBar('CO2排出量'),
            const SizedBox(height: 12),
            _buildComparisonBar('輸送距離'),
            const SizedBox(height: 12),
            _buildComparisonBar('総評'),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonBar(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 47, // 47%を表現
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFF008080),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 53, // 53%を表現
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFF3CB371),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '総評',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text('商品Aは商品Bと比較して環境負荷が47.4%低く、より環境に配慮した選択肢です。'),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: 商品選択時の処理を実装
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF008080),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          '商品Aを選択',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
