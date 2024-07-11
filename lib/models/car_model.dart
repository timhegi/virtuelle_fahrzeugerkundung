import 'dart:ui';

import 'package:hive/hive.dart';

part 'car_model.g.dart';

class ColorInfo {
  final Color color;
  final String name;

  factory ColorInfo.fromJson(Map<String, dynamic> json) {
    return ColorInfo(
      color: Color(json['color']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color.value,
      'name': name,
    };
  }

  ColorInfo({
    required this.color,
    required this.name,
  });
}

@HiveType(typeId: 1)
class Car {
  @HiveField(0)
  final String? model;
  @HiveField(1)
  final String? brand;
  @HiveField(2)
  final String? type;
  @HiveField(3)
  final String? baseColor;
  @HiveField(4)
  final double? price;
  @HiveField(5)
  final String? images;
  @HiveField(6)
  final List<ColorInfo> exteriorColors;
  @HiveField(7)
  final List<ColorInfo> interiorColors;
  @HiveField(8)
  final List<ColorInfo> brakeColors;
  @HiveField(9)
  final List<String> fuelTypes;
  @HiveField(10)
  final String? selectedExteriorColor;
  @HiveField(11)
  final String? selectedInteriorColor;
  @HiveField(12)
  final String? selectedBrakeColor;
  @HiveField(13)
  final String? selectedFuelType;

  Car({
    this.model,
    this.brand,
    this.type,
    this.baseColor,
    this.price,
    this.images,
    List<ColorInfo>? exteriorColors,
    List<ColorInfo>? interiorColors,
    List<ColorInfo>? brakeColors,
    List<String>? fuelTypes,
    this.selectedExteriorColor,
    this.selectedInteriorColor,
    this.selectedBrakeColor,
    this.selectedFuelType,
  })  : exteriorColors = exteriorColors ?? [],
        interiorColors = interiorColors ?? [],
        brakeColors = brakeColors ?? [],
        fuelTypes = fuelTypes ?? [];
}
