class RecentScan {
  final String productName;
  final String manufacturer;
  final String score; // From A to E
  final DateTime scannedAt;

  RecentScan({
    required this.productName,
    required this.manufacturer,
    required this.score,
    required this.scannedAt,
  });
}
