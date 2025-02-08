// lib/features/barcode_scan/presentation/bloc/scan_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/models/product.dart';
import '../../domain/models/environmental_impact.dart';

abstract class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object?> get props => [];
}

class ScanInitial extends ScanState {}

class ScanInProgress extends ScanState {}

class ScanSuccess extends ScanState {
  final Product product;
  final EnvironmentalImpact environmentalImpact;

  const ScanSuccess({
    required this.product,
    required this.environmentalImpact,
  });

  @override
  List<Object> get props => [product, environmentalImpact];
}

class ScanFailure extends ScanState {
  final String message;

  const ScanFailure(this.message);

  @override
  List<Object> get props => [message];
}

// lib/features/barcode_scan/presentation/bloc/scan_event.dart
abstract class ScanEvent extends Equatable {
  const ScanEvent();

  @override
  List<Object?> get props => [];
}

class BarcodeScanned extends ScanEvent {
  final String barcode;

  const BarcodeScanned(this.barcode);

  @override
  List<Object> get props => [barcode];
}

class ClearScan extends ScanEvent {}
