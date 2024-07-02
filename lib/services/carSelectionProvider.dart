import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/car_model.dart';

class CarSelectionProvider extends ChangeNotifier {
  Car? _selectedCar;

  Car? get selectedCar => _selectedCar;

  void selectCar(Car car) {
    _selectedCar = car;
    notifyListeners();
  }
}
