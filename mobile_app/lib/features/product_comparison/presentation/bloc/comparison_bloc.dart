import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/features/product_comparison/domain/models/comparison_product.dart';
import 'package:mobile_app/features/product_comparison/domain/comparison_calculator.dart';
import 'comparison_state.dart';

// イベントの定義
abstract class ComparisonEvent {}

class LoadProductsEvent extends ComparisonEvent {
  final ComparisonProduct productA;
  final ComparisonProduct productB;

  LoadProductsEvent({required this.productA, required this.productB});
}

// BLoCの実装
class ComparisonBloc extends Bloc<ComparisonEvent, ComparisonState> {
  ComparisonBloc() : super(const ComparisonState()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ComparisonState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      // 商品情報を設定
      emit(state.copyWith(
        productA: event.productA,
        productB: event.productB,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  String get comparisonSummary {
    if (state.productA == null || state.productB == null) {
      return '';
    }
    return ComparisonCalculator.generateComparisonSummary(
      state.productA!,
      state.productB!,
    );
  }

  double get emissionDifference {
    if (state.productA == null || state.productB == null) {
      return 0.0;
    }
    return ComparisonCalculator.calculateEmissionDifference(
      state.productA!,
      state.productB!,
    );
  }
}
