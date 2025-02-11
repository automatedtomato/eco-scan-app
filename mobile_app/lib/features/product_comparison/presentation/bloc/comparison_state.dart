import 'package:equatable/equatable.dart';
import 'package:mobile_app/features/product_comparison/domain/models/comparison_product.dart';

class ComparisonState extends Equatable {
  final ComparisonProduct? productA;
  final ComparisonProduct? productB;
  final bool isLoading;
  final String? error;

  const ComparisonState({
    this.productA,
    this.productB,
    this.isLoading = false,
    this.error,
  });

  ComparisonState copyWith({
    ComparisonProduct? productA,
    ComparisonProduct? productB,
    bool? isLoading,
    String? error,
  }) {
    return ComparisonState(
      productA: productA ?? this.productA,
      productB: productB ?? this.productB,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [productA, productB, isLoading, error];
}
