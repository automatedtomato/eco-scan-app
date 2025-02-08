import 'package:flutter/material.dart';
import '../../domain/models/monthly_report.dart';

class EcoReportPage extends StatelessWidget {
  const EcoReportPage({super.key});

  // テスト用のダミーデータ
  MonthlyReport _getSampleData() {
    return MonthlyReport(
      month: DateTime.now(),
      totalCO2: 55.4,
      previousMonthCO2: 63.0,
      co2Trend: [50.0, 48.0, 52.0, 49.0, 55.4],
      hint: '商品Aを商品Bに変更することで、CO2排出量を20%削減できます。',
    );
  }

  @override
  Widget build(BuildContext context) {
    final report = _getSampleData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('環境影響レポート'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 期間選択
            _buildPeriodSelector(),
            const SizedBox(height: 24),

            // 今月の環境影響
            _buildCurrentMonthImpact(report),
            const SizedBox(height: 24),

            // CO2排出量推移グラフ
            _buildCO2TrendChart(report),
            const SizedBox(height: 24),

            // 環境負荷削減のヒント
            _buildEnvironmentalHint(report),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

  Widget _buildCurrentMonthImpact(MonthlyReport report) {
    final changeColor = report.monthlyChange < 0 ? Colors.green : Colors.red;
    final changePrefix = report.monthlyChange < 0 ? '' : '+';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '今月の環境影響',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '総CO2排出量',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${report.totalCO2}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(' kg'),
                const Spacer(),
                Text(
                  '前月比',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$changePrefix${report.monthlyChange.toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: changeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCO2TrendChart(MonthlyReport report) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CO2排出量推移',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: _SimpleTrendLine(data: report.co2Trend),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentalHint(MonthlyReport report) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '環境負荷削減のヒント',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(report.hint),
          ],
        ),
      ),
    );
  }
}

// シンプルな折れ線グラフのウィジェット
class _SimpleTrendLine extends StatelessWidget {
  final List<double> data;

  const _SimpleTrendLine({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 200),
      painter: _TrendLinePainter(data),
    );
  }
}

class _TrendLinePainter extends CustomPainter {
  final List<double> data;

  _TrendLinePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFF008080)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final max = data.reduce((curr, next) => curr > next ? curr : next);
    final min = data.reduce((curr, next) => curr < next ? curr : next);
    final range = max - min;

    for (var i = 0; i < data.length; i++) {
      final x = size.width * i / (data.length - 1);
      final y = size.height - ((data[i] - min) / range * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // ポイントを描画
    final pointPaint = Paint()
      ..color = const Color(0xFF008080)
      ..style = PaintingStyle.fill;

    for (var i = 0; i < data.length; i++) {
      final x = size.width * i / (data.length - 1);
      final y = size.height - ((data[i] - min) / range * size.height);
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
