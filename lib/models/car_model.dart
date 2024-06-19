import 'package:hive/hive.dart';

// part "car_model.g.dart"; // Auskommentiert, da bei meinem aktuellen stand noch fehler auftreten

@HiveType(typeId: 1)
class Car{
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

  Car({
    required this.model,
    required this.brand,
    required this.type,
    required this.baseColor,
    required this.price
  });
}