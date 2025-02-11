import 'package:mobile_app/features/product_comparison/domain/models/comparison_product.dart';

class ComparisonCalculator {
  /// CO2排出量の差分を計算（%）
  static double calculateEmissionDifference(
    ComparisonProduct productA,
    ComparisonProduct productB,
  ) {
    return ((productA.emission - productB.emission) / productB.emission * 100)
        .roundToDouble();
  }

  /// より環境に優しい商品を判定
  static ComparisonProduct? getMoreEnvironmentallyFriendly(
    ComparisonProduct productA,
    ComparisonProduct productB,
  ) {
    if (productA.emission < productB.emission) {
      return productA;
    } else if (productB.emission < productA.emission) {
      return productB;
    }
    return null;

    /// 両方の商品のCO2排出量が同じ場合
  }

  /// 総合的な比較テキストを生成
  static String generateComparisonSummary(
    ComparisonProduct productA,
    ComparisonProduct productB,
  ) {
    final difference = calculateEmissionDifference(productA, productB);
    final better = getMoreEnvironmentallyFriendly(productA, productB);

    if (better == null) {
      return '両商品の環境負荷は同程度です。';
    }

    final betterName = better == productA ? '商品A' : '商品B';
    final worseName = better == productA ? '商品B' : '商品A';

    return '$betterNameは$worseNameと比較して環境負荷が${difference.abs().toStringAsFixed(1)}%${difference < 0 ? '高く' : '低く'}、${difference < 0 ? 'より注意が必要です。' : 'より環境に配慮した選択肢です。'}';
  }
}
