import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/features/product_comparison/domain/models/comparison_product.dart';
import 'package:mobile_app/features/product_comparison/presentation/bloc/comparison_bloc.dart';
import 'package:mobile_app/features/product_comparison/presentation/bloc/comparison_state.dart';

class ProductComparePage extends StatefulWidget {
  final ComparisonProduct productA;
  final ComparisonProduct productB;

  const ProductComparePage({
    super.key,
    required this.productA,
    required this.productB,
  });

  @override
  State<ProductComparePage> createState() => _ProductComparePageState();
}

class _ProductComparePageState extends State<ProductComparePage> {
  late final ComparisonBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ComparisonBloc()
      ..add(LoadProductsEvent(
        productA: widget.productA,
        productB: widget.productB,
      ));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<ComparisonBloc, ComparisonState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('エラー: ${state.error}'));
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('商品比較'),
              backgroundColor: const Color(0xFF008080),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProductComparisonCard(state),
                  const SizedBox(height: 24),
                  _buildComparisonAnalysis(state),
                  const SizedBox(height: 24),
                  _buildSummary(state),
                  const SizedBox(height: 24),
                  _buildSelectButton(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductComparisonCard(ComparisonState state) {
    final productA = state.productA;
    final productB = state.productB;

    if (productA == null || productB == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        // 商品A
        Expanded(
          child: _buildProductCard(
            product: productA,
            isProductA: true,
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
          child: _buildProductCard(
            product: productB,
            isProductA: false,
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required ComparisonProduct product,
    required bool isProductA,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              product.manufacturer,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            // スコア表示
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isProductA
                    ? const Color(0xFF008080)
                    : const Color(0xFF3CB371),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  product.score,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'CO2: ${product.emission}kg',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              '輸送: ${product.transportDistance}km',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonAnalysis(ComparisonState state) {
    if (state.productA == null || state.productB == null) {
      return const SizedBox.shrink();
    }

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
            _buildComparisonBar(
              label: 'CO2排出量',
              valueA: state.productA!.emission,
              valueB: state.productB!.emission,
            ),
            const SizedBox(height: 12),
            _buildComparisonBar(
              label: '輸送距離',
              valueA: state.productA!.transportDistance.toDouble(),
              valueB: state.productB!.transportDistance.toDouble(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonBar({
    required String label,
    required double valueA,
    required double valueB,
  }) {
    final total = valueA + valueB;
    final flexA = ((valueA / total) * 100).round();
    final flexB = 100 - flexA;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: flexA,
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
              flex: flexB,
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

  Widget _buildSummary(ComparisonState state) {
    if (state.productA == null || state.productB == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '総評',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(_bloc.comparisonSummary),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectButton(ComparisonState state) {
    if (state.productA == null || state.productB == null) {
      return const SizedBox.shrink();
    }

    // より環境に優しい商品を判定
    final difference = _bloc.emissionDifference;
    final selectProductA = difference <= 0;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: 商品選択時の処理を実装
          Navigator.of(context)
              .pop(selectProductA ? state.productA : state.productB);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF008080),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          '${selectProductA ? "商品A" : "商品B"}を選択',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
