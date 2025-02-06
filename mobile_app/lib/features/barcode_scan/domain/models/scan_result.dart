class ScanResult {
  final String barcode;
  final DateTime scannedAt;

  ScanResult({
    required this.barcode,
    DateTime? scannedAt,
  }) : scannedAt = scannedAt ?? DateTime.now();
}
