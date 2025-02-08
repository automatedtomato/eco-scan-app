import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/models/environmental_impact.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  static const String _baseUrl = 'https://api.ecoscan.example.com/v1';
  final http.Client _client;

  ProductRepositoryImpl({http.Client? client})
      : _client = client ?? http.Client();

  @override
  Future<Product> getProduct(String barcode) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/products/$barcode'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body)['data'];
        return Product.fromJson(json);
      } else if (response.statusCode == 404) {
        throw ProductNotFoundException(barcode);
      } else {
        throw ApiException(
          'Failed to fetch product data',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ProductNotFoundException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<EnvironmentalImpact> getEnvironmentalImpact(String barcode) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/environmental-impact/$barcode'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body)['data'];
        return EnvironmentalImpact.fromJson(json);
      } else if (response.statusCode == 404) {
        throw ProductNotFoundException(
            barcode, 'Environmental impact data not found');
      } else {
        throw ApiException(
          'Failed to fetch environmental impact data',
          response.statusCode,
        );
      }
    } catch (e) {
      if (e is ProductNotFoundException) rethrow;
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> saveScanResult(String barcode, DateTime scannedAt) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/scan-history'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'barcode': barcode,
          'scanned_at': scannedAt.toIso8601String(),
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          'Failed to save scan result',
          response.statusCode,
        );
      }
    } catch (e) {
      throw ApiException('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    // TODO: 認証トークンの取得処理を実装
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Api-Version': '2024-02-06',
    };
  }
}
