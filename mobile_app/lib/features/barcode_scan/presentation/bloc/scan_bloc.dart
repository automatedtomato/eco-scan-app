// lib/features/barcode_scan/presentation/bloc/scan_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/product_repository.dart';
import 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ProductRepository _productRepository;

  ScanBloc({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(ScanInitial()) {
    on<BarcodeScanned>(_onBarcodeScanned);
    on<ClearScan>(_onClearScan);
  }

  Future<void> _onBarcodeScanned(
    BarcodeScanned event,
    Emitter<ScanState> emit,
  ) async {
    try {
      emit(ScanInProgress());

      final product = await _productRepository.getProduct(event.barcode);
      final environmentalImpact =
          await _productRepository.getEnvironmentalImpact(event.barcode);

      // スキャン履歴を保存
      await _productRepository.saveScanResult(event.barcode, DateTime.now());

      emit(ScanSuccess(
        product: product,
        environmentalImpact: environmentalImpact,
      ));
    } on ProductNotFoundException catch (e) {
      emit(ScanFailure('商品が見つかりません: ${e.message}'));
    } on ApiException catch (e) {
      emit(ScanFailure('エラーが発生しました: ${e.message}'));
    } catch (e) {
      emit(ScanFailure('予期せぬエラーが発生しました: ${e.toString()}'));
    }
  }

  void _onClearScan(
    ClearScan event,
    Emitter<ScanState> emit,
  ) {
    emit(ScanInitial());
  }
}
