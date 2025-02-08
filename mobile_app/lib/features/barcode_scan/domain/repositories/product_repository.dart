import '../models/environmental_impact.dart';
import '../models/product.dart';

abstract class ProductRepository {
  /// 商品情報の取得
  Future<Product> getProduct(String barcode);

  /// 商品の環境影響情報の取得
  Future<EnvironmentalImpact> getEnvironmentalImpact(String barcode);

  /// スキャン結果の保存
  Future<void> saveScanResult(String barcode, DateTime scannedAt);
}

/// エラーハンドリング用の例外クラス
class ProductNotFoundException implements Exception {
  final String barcode;
  final String message;

  ProductNotFoundException(this.barcode, [this.message = 'Product not found']);

  @override
  String toString() => 'ProductNotFoundException: $message (barcode: $barcode)';
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (status: $statusCode)' : ''}';
}
