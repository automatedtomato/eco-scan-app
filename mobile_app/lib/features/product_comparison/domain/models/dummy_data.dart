import 'comparison_product.dart';

class DummyProducts {
  static ComparisonProduct productA = ComparisonProduct(
    name: 'エコ商品A',
    manufacturer: 'メーカーA',
    score: 'A',
    emission: 1.23,
    transportDistance: 100,
  );

  static ComparisonProduct productB = ComparisonProduct(
    name: 'エコ商品B',
    manufacturer: 'メーカーB',
    score: 'B',
    emission: 2.34,
    transportDistance: 150,
  );
}
