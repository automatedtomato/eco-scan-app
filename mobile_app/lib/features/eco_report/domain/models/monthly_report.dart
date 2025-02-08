class MonthlyReport {
  final DateTime month;
  final double totalCO2;
  final double previousMonthCO2;
  final List<double> co2Trend;
  final String hint;

  MonthlyReport({
    required this.month,
    required this.totalCO2,
    required this.previousMonthCO2,
    required this.co2Trend,
    required this.hint,
  });

  double get monthlyChange {
    if (previousMonthCO2 == 0) return 0;
    return ((totalCO2 - previousMonthCO2) / previousMonthCO2) * 100;
  }
}
