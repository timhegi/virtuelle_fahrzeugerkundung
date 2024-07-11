import 'package:flutter/material.dart';

import 'car_model.dart';

class CarObject {
  final String? model;
  final String? brand;
  final String? type;
  final String? baseColor;
  final double? price;
  final String? images;
  final List<ColorInfo> exteriorColors;
  final List<ColorInfo> interiorColors;
  final List<ColorInfo> brakeColors;
  final List<String> fuelTypes;
  final String? selectedExteriorColor;
  final String? selectedInteriorColor;
  final String? selectedBrakeColor;
  final String? selectedFuelType;

  CarObject({
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
