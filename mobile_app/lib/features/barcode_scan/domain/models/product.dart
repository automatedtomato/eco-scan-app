class Product {
  final String barcode;
  final String name;
  final String manufacturer;
  final String category;
  final ProductSpecifications specifications;
  final ProductMetadata metadata;

  Product({
    required this.barcode,
    required this.name,
    required this.manufacturer,
    required this.category,
    required this.specifications,
    required this.metadata,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barcode: json['barcode'],
      name: json['name'],
      manufacturer: json['manufacturer'],
      category: json['category']['name'],
      specifications: ProductSpecifications.fromJson(json['specifications']),
      metadata: ProductMetadata.fromJson(json['metadata']),
    );
  }

  Map<String, dynamic> toJson() => {
        'barcode': barcode,
        'name': name,
        'manufacturer': manufacturer,
        'category': {'name': category},
        'specifications': specifications.toJson(),
        'metadata': metadata.toJson(),
      };
}

class ProductSpecifications {
  final double weight;
  final String weightUnit;
  final ProductDimensions dimensions;

  ProductSpecifications({
    required this.weight,
    required this.weightUnit,
    required this.dimensions,
  });

  factory ProductSpecifications.fromJson(Map<String, dynamic> json) {
    return ProductSpecifications(
      weight: json['weight'].toDouble(),
      weightUnit: json['weightUnit'],
      dimensions: ProductDimensions.fromJson(json['dimensions']),
    );
  }

  Map<String, dynamic> toJson() => {
        'weight': weight,
        'weightUnit': weightUnit,
        'dimensions': dimensions.toJson(),
      };
}

class ProductDimensions {
  final double width;
  final double height;
  final double depth;
  final String unit;

  ProductDimensions({
    required this.width,
    required this.height,
    required this.depth,
    required this.unit,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      depth: json['depth'].toDouble(),
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
        'depth': depth,
        'unit': unit,
      };
}

class ProductMetadata {
  final DateTime registeredAt;
  final DateTime updatedAt;
  final String source;

  ProductMetadata({
    required this.registeredAt,
    required this.updatedAt,
    required this.source,
  });

  factory ProductMetadata.fromJson(Map<String, dynamic> json) {
    return ProductMetadata(
      registeredAt: DateTime.parse(json['registeredAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() => {
        'registeredAt': registeredAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'source': source,
      };
}
