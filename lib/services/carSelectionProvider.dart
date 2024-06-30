import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import '../models/car_model.dart';

class CarSelectionProvider extends ChangeNotifier {
  Car? _selectedCar;

  Car? get selectedCar => _selectedCar;

  void selectCar(Car car) {
    _selectedCar = car;
    developer.log('Car selected: ${car.model} - ${car.brand} - ${car.price}', name: 'CarSelection'); // TODO: Remove this line
    notifyListeners();
  }
}
