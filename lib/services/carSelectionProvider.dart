import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/car.dart';
import '../models/car_model.dart';

class CarSelectionProvider extends ChangeNotifier {
  CarObject? _selectedCar;
  ColorInfo? _selectedExteriorColor;
  ColorInfo? _selectedInteriorColor;
  ColorInfo? _selectedBrakeColor;
  String? _selectedFuelType;

  CarObject? get selectedCar => _selectedCar;

  ColorInfo? get selectedExteriorColor => _selectedExteriorColor;

  ColorInfo? get selectedInteriorColor => _selectedInteriorColor;

  ColorInfo? get selectedBrakeColor => _selectedBrakeColor;

  String? get selectedFuelType => _selectedFuelType;

  void selectCar(CarObject car) {
    _selectedCar = car;
    _selectedExteriorColor = car.exteriorColors.firstWhere(
      (color) => color.name == car.baseColor,
      orElse: () => car.exteriorColors.first,
    );
    _selectedInteriorColor =
        car.interiorColors.isNotEmpty ? car.interiorColors.first : null;
    _selectedBrakeColor =
        car.brakeColors.isNotEmpty ? car.brakeColors.first : null;
    _selectedFuelType = car.fuelTypes.isNotEmpty ? car.fuelTypes.first : null;
    notifyListeners();
  }

  void saveCurrentConfiguration() {
    if (_selectedCar != null) {
      final Box<Car> carBox = Hive.box<Car>('cars');
      final updatedCar = Car(
        model: _selectedCar!.model,
        brand: _selectedCar!.brand,
        type: _selectedCar!.type,
        baseColor: _selectedExteriorColor?.name ?? _selectedCar!.baseColor,
        price: _selectedCar!.price,
        images: _selectedCar!.images,
        exteriorColors: _selectedCar!.exteriorColors,
        interiorColors: _selectedCar!.interiorColors,
        brakeColors: _selectedCar!.brakeColors,
        fuelTypes: _selectedCar!.fuelTypes,
        selectedExteriorColor: _selectedExteriorColor?.name,
        selectedInteriorColor: _selectedInteriorColor?.name,
        selectedBrakeColor: _selectedBrakeColor?.name,
        selectedFuelType: _selectedFuelType,
      );
      carBox.add(updatedCar);
    }
  }

  void selectExteriorColor(ColorInfo color) {
    _selectedExteriorColor = color;
    notifyListeners();
  }

  void selectInteriorColor(ColorInfo color) {
    _selectedInteriorColor = color;
    notifyListeners();
  }

  void selectBrakeColor(ColorInfo color) {
    _selectedBrakeColor = color;
    notifyListeners();
  }

  void selectFuelType(String fuelType) {
    _selectedFuelType = fuelType;
    notifyListeners();
  }
}
