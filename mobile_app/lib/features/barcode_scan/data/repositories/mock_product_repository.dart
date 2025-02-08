// lib/features/barcode_scan/data/repositories/mock_product_repository.dart

import '../../domain/models/product.dart';
import '../../domain/models/environmental_impact.dart';
import '../../domain/repositories/product_repository.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<Product> getProduct(String barcode) async {
    // 開発用のモックデータ
    await Future.delayed(const Duration(seconds: 1)); // 実際のAPI呼び出しを模倣

    return Product(
      barcode: barcode,
      name: 'テスト商品',
      manufacturer: 'テストメーカー',
      category: '食品',
      specifications: ProductSpecifications(
        weight: 100,
        weightUnit: 'g',
        dimensions: ProductDimensions(
          width: 50,
          height: 100,
          depth: 50,
          unit: 'mm',
        ),
      ),
      metadata: ProductMetadata(
        registeredAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'mock_data',
      ),
    );
  }

  @override
  Future<EnvironmentalImpact> getEnvironmentalImpact(String barcode) async {
    await Future.delayed(const Duration(seconds: 1));

    return EnvironmentalImpact(
      score: EnvironmentalScore(
        grade: 'A',
        numericScore: 85,
        confidence: 0.92,
      ),
      emissions: Emissions(
        co2: CO2Emission(
          value: 1.23,
          unit: 'kgCO2e',
          confidence: 0.95,
          breakdown: {
            'manufacturing': 0.5,
            'transport': 0.3,
            'disposal': 0.43,
          },
          source: 'mock_data',
        ),
      ),
      certifications: Certifications(
        ecoMark: EcoMark(
          certified: true,
          certificateId: '12345',
          validUntil: DateTime.now().add(const Duration(days: 365)),
          source: 'mock_data',
        ),
      ),
      dataSources: ['mock_data'],
    );
  }

  @override
  Future<void> saveScanResult(String barcode, DateTime scannedAt) async {
    // モック実装では何もしない
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
