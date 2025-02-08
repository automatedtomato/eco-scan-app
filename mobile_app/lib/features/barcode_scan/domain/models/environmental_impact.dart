class EnvironmentalImpact {
  final EnvironmentalScore score;
  final Emissions emissions;
  final Certifications certifications;
  final List<String> dataSources;

  EnvironmentalImpact({
    required this.score,
    required this.emissions,
    required this.certifications,
    required this.dataSources,
  });

  factory EnvironmentalImpact.fromJson(Map<String, dynamic> json) {
    return EnvironmentalImpact(
      score: EnvironmentalScore.fromJson(json['summary']['total_score']),
      emissions: Emissions.fromJson(json['emissions']),
      certifications: Certifications.fromJson(json['certifications']),
      dataSources: List<String>.from(json['summary']['data_sources']),
    );
  }

  Map<String, dynamic> toJson() => {
        'summary': {
          'total_score': score.toJson(),
          'data_sources': dataSources,
        },
        'emissions': emissions.toJson(),
        'certifications': certifications.toJson(),
      };
}

class EnvironmentalScore {
  final String grade;
  final int numericScore;
  final double confidence;

  EnvironmentalScore({
    required this.grade,
    required this.numericScore,
    required this.confidence,
  });

  factory EnvironmentalScore.fromJson(Map<String, dynamic> json) {
    return EnvironmentalScore(
      grade: json['value'],
      numericScore: json['numeric'],
      confidence: json['confidence'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'value': grade,
        'numeric': numericScore,
        'confidence': confidence,
      };
}

class Emissions {
  final CO2Emission co2;

  Emissions({
    required this.co2,
  });

  factory Emissions.fromJson(Map<String, dynamic> json) {
    return Emissions(
      co2: CO2Emission.fromJson(json['co2']),
    );
  }

  Map<String, dynamic> toJson() => {
        'co2': co2.toJson(),
      };
}

class CO2Emission {
  final double value;
  final String unit;
  final double confidence;
  final Map<String, double> breakdown;
  final String source;

  CO2Emission({
    required this.value,
    required this.unit,
    required this.confidence,
    required this.breakdown,
    required this.source,
  });

  factory CO2Emission.fromJson(Map<String, dynamic> json) {
    return CO2Emission(
      value: json['value'].toDouble(),
      unit: json['unit'],
      confidence: json['confidence'].toDouble(),
      breakdown: Map<String, double>.from(json['breakdown']),
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'unit': unit,
        'confidence': confidence,
        'breakdown': breakdown,
        'source': source,
      };
}

class Certifications {
  final EcoMark? ecoMark;

  Certifications({
    this.ecoMark,
  });

  factory Certifications.fromJson(Map<String, dynamic> json) {
    return Certifications(
      ecoMark:
          json['eco_mark'] != null ? EcoMark.fromJson(json['eco_mark']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'eco_mark': ecoMark?.toJson(),
      };
}

class EcoMark {
  final bool certified;
  final String? certificateId;
  final DateTime? validUntil;
  final String source;

  EcoMark({
    required this.certified,
    this.certificateId,
    this.validUntil,
    required this.source,
  });

  factory EcoMark.fromJson(Map<String, dynamic> json) {
    return EcoMark(
      certified: json['certified'],
      certificateId: json['certificate_id'],
      validUntil: json['valid_until'] != null
          ? DateTime.parse(json['valid_until'])
          : null,
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() => {
        'certified': certified,
        'certificate_id': certificateId,
        'valid_until': validUntil?.toIso8601String(),
        'source': source,
      };
}
