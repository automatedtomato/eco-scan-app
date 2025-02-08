class ScanHistoryItem {
  final String productName;
  final String manufacturer;
  final String score;
  final DateTime scannedAt;

  ScanHistoryItem({
    required this.productName,
    required this.manufacturer,
    required this.score,
    required this.scannedAt,
  });

  String get formattedDate {
    return '${scannedAt.year}年${scannedAt.month}月${scannedAt.day}日';
  }
}
