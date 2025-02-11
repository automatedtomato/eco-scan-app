import 'package:equatable/equatable.dart';

class ComparisonProduct extends Equatable {
  final String name;
  final String manufacturer;
  final String score;
  final double emission;
  final int transportDistance;

  ComparisonProduct({
    required this.name,
    required this.manufacturer,
    required this.score,
    required this.emission,
    required this.transportDistance,
  });

  // JSONからオブジェクトを作成
  factory ComparisonProduct.fromJson(Map<String, dynamic> json) {
    return ComparisonProduct(
      name: json['name'] as String,
      manufacturer: json['manufacturer'] as String,
      score: json['score'] as String,
      emission: json['emission'] as double,
      transportDistance: json['transportDistance'] as int,
    );
  }

  // オブジェクトをJSONに変換
  Map<String, dynamic> toJson() => {
        'name': name,
        'manufacturer': manufacturer,
        'score': score,
        'emission': emission,
        'transportDistance': transportDistance,
      };

  @override
  List<Object?> get props =>
      [name, manufacturer, score, emission, transportDistance];

  // オブジェクトのコピーを作成し、特定のフィールドを更新
  ComparisonProduct copyWith({
    String? name,
    String? manufacturer,
    String? score,
    double? emission,
    int? transportDistance,
  }) {
    return ComparisonProduct(
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      score: score ?? this.score,
      emission: emission ?? this.emission,
      transportDistance: transportDistance ?? this.transportDistance,
    );
  }
}
